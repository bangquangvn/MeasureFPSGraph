//
//  FPSGraphViewController.h
//  MeasureFPSGraph
//
//  Created by trongbangvp@gmail.com on 6/2/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <vector>

@interface FPSGraphViewController : UIViewController

-(instancetype)initWithSamples:(std::vector<float>)samples totalTime:(float)totalTimeSec;

@end
