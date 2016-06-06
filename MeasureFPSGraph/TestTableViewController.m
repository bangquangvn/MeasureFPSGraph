//
//  TestTableViewController.m
//  MeasureFPSGraph
//
//  Created by trongbangvp@gmail.com on 6/2/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//

#import "TestTableViewController.h"
#import "BadCell.h"
#import "RRFPSBar.h"

#define cellId @"cellId"

@interface TestTableViewController()<UITableViewDelegate, UITableViewDataSource>
{
    NSTimer* autoScrollTimer;
}
@end
@implementation TestTableViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[BadCell class] forCellReuseIdentifier:cellId];
    
    autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

-(void) autoScroll
{
    float maxOffsetY = self.tableView.contentSize.height - self.tableView.frame.size.height;
    float newOffsetY = self.tableView.contentOffset.y + 8;
    if(newOffsetY > maxOffsetY)
    {
        newOffsetY = maxOffsetY;
        [autoScrollTimer invalidate];
        [[RRFPSBar sharedInstance] showFPSGraph];
    }
    [self.tableView setContentOffset:CGPointMake(0, newOffsetY) animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 + rand() % 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BadCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = [NSString stringWithFormat:@"Test cell %zd", indexPath.row];
    [cell setupWithNewInfo];
    return cell;
}

@end
