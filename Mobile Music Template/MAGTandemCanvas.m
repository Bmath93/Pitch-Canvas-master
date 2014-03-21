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
    [super viewDidLoad];
    self.manager = [[OSCManager alloc] init];
    [self.manager setDelegate:self];
    self.outport = [self.manager createNewOutputToAddress:@"localhost" atPort:7000];
    [self.manager createNewInputForPort:7000];
}

- (IBAction)backToSetup:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)sendOSCstuff:(id)sender {
    //OSCMessage *newMsg = [[OSCMessage alloc] initWithAddress:@"empty"];
    OSCMessage *newMsg = [OSCMessage createWithAddress:@"empty"];
}

@end