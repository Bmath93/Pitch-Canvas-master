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
}

- (IBAction)backToSetup:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)sendOSCstuff:(id)sender {
    OSCManager *manager = [[OSCManager alloc] init];
    [manager setDelegate:self];
    
    OSCOutPort *outport = [manager createNewOutputToAddress:@"localhost" atPort:7000];
    
    [manager createNewInputForPort:7000];
    
    //OSCMessage *newMsg = [OSCMessage createWithAddress:@"/Address/Path/1"];
}

@end