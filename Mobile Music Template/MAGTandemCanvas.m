//
//  MAGTandemCanvas.m
//  PitchCanvas
//
//  Created by Student Researcher on 2/21/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGTandemCanvas.h"

#import <VVOSC/VVOSC.h>
#import <VVOSC/OSCManager.h>
#import <VVOSC/OSCInPort.h>
#import <VVOSC/OSCOutPort.h>
#import <VVOSC/OSCMessage.h>

#define ADDRESS "localhost"
#define PORT 7000

#define OUTPUT_BUFFER_SIZE 1024

@implementation MAGTandemCanvas

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad called");
    [super viewDidLoad];
    if (!self.manager){
        NSLog(@"!self.manager");
        self.manager = [[OSCManager alloc] init];
        [self.manager setDelegate:self];
    }
    if (!self.outport){
        NSLog(@"!self.outport");
        self.outport = [self.manager createNewOutputToAddress:@"localhost" atPort:30200];
        [self.manager createNewInputForPort:30200];
    }
}

- (IBAction)backToSetup:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)sendOSCstuff:(id)sender {
    OSCMessage *newMsg = [OSCMessage createWithAddress:@"/Address/Path/1"];
    [newMsg addFloat:12.34];
    [self.outport sendThisMessage:newMsg];
}

@end