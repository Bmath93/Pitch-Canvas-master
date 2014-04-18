//
//  MAGTopViewController.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGTopViewController.h"

@interface MAGPdButler ()

@end

@implementation MAGTopViewController

@synthesize pdButler;

- (void)viewDidLoad{
    [super viewDidLoad];
	
    self.pdButler = [[MAGPdButler alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loadCanvasSettings"])
    {
        NSLog(@"loading CanvasSettings");
        
        [segue.destinationViewController setPdButler:self.pdButler];
        //[segue.destinationViewController setBaseKey:([self.keySwitch selectedSegmentIndex] + 45 + (12 * [self.baseRange selectedSegmentIndex]))];
        //[segue.destinationViewController setCircleSize:([self.sizeSwitch selectedSegmentIndex]*50.0 + 50.0)];
        //[segue.destinationViewController setShift:([self.shiftSwitch selectedSegmentIndex])];
        //[segue.destinationViewController setMultipleKeys:([self.multipleKeySwitch selectedSegmentIndex])];
    }
}

@end
