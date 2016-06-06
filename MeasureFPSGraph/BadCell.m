//
//  BadCell.m
//  MeasureFPSGraph
//
//  Created by trongbangvp@gmail.com on 6/2/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//

#import "BadCell.h"

#define RANDOM_O_1() (rand()%INT_MAX / ((float)INT_MAX) )

@implementation BadCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        CGRect frame = self.frame;
        int w_2 = frame.size.width/2;
        int h_2 = frame.size.height/2;
        int n = 10 + rand() % 10;
        for(int i = 0;i<n;++i)
        {
            UIView* v = [[UIView alloc] initWithFrame:CGRectInset(frame, rand()%w_2, rand()%h_2)];
            v.backgroundColor = [UIColor colorWithRed:RANDOM_O_1() green:RANDOM_O_1() blue:RANDOM_O_1() alpha:RANDOM_O_1()];
            v.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:v];
        }
    }
    return self;
}

-(void) setupWithNewInfo
{
    [UIView animateWithDuration:0.2 animations:^{
        for(UIView* subView in self.subviews)
        {
            subView.backgroundColor = [UIColor colorWithRed:RANDOM_O_1() green:RANDOM_O_1() blue:RANDOM_O_1() alpha:RANDOM_O_1()];
        }
    }];
}

@end
