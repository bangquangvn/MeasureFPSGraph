//
//  FPSGraphViewController.m
//  MeasureFPSGraph
//
//  Created by trongbangvp@gmail.com on 6/2/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import "FPSGraphViewController.h"

@implementation FPSGraphViewController
{
    std::vector<float> _fpsSamples;
    float _totalTime;
}
-(instancetype)initWithSamples:(std::vector<float>)samples totalTime:(float)totalTimeSec
{
    if(self = [super init])
    {
        _fpsSamples = samples;
        _totalTime = totalTimeSec;
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    
    float screenW = self.view.frame.size.width;
    float screenH = self.view.frame.size.height;
    uint32_t numSample = _fpsSamples.size();
    float averageFps = numSample / _totalTime;
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = CGSizeMake(numSample, screenH);
    [self.view addSubview:scrollView];
    
    // Chart Layer
    CGRect chartFrame = {0,0, (float)numSample, screenH};
    CAShapeLayer* _chartLayer = [CAShapeLayer layer];
    [_chartLayer setFrame:chartFrame];
    [_chartLayer setStrokeColor: [UIColor redColor].CGColor];
    [_chartLayer setContentsScale: [UIScreen mainScreen].scale];
    [scrollView.layer addSublayer:_chartLayer];
    
    const float minFps = 40;
    const float maxFps = 65;
    const float range = maxFps - minFps;
    
    UILabel* minLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    minLb.text = [NSString stringWithFormat:@"%2.0f FPS", minFps];
    UILabel* maxLb = [[UILabel alloc] initWithFrame:CGRectMake(0, screenH - 50, 100, 50)];
    maxLb.text = [NSString stringWithFormat:@"%2.0f FPS", maxFps];
    maxLb.textColor = [UIColor yellowColor];
    minLb.textColor = [UIColor greenColor];
    [self.view addSubview:minLb];
    [self.view addSubview:maxLb];
    
    UITextView* infoTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, screenW, 100)];
    infoTextView.editable = NO;
    infoTextView.textColor = [UIColor whiteColor];
    infoTextView.text = [NSString stringWithFormat:@"Total frame: %u, total time: %0.2f sec, average FPS: %0.2f", numSample, _totalTime , averageFps];
    infoTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:infoTextView];
    
    float y = 0;
    float p;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointZero];
    
    for(unsigned long i = 0; i<numSample; ++i)
    {
        printf("%f ", _fpsSamples.at(i));
        float currFps = _fpsSamples.at(i);
        p = (currFps - minFps) / range;
        y = p * screenH;
        CGPathAddLineToPoint(path, nil, i, y);
        
        [bezierPath addLineToPoint:CGPointMake(i, y)];
    }
    _chartLayer.path = bezierPath.CGPath;
//    _chartLayer.path = path;
    
    if( [_chartLayer respondsToSelector:@selector(setDrawsAsynchronously:)] ){
        [_chartLayer setDrawsAsynchronously:YES];
    }
}
@end
