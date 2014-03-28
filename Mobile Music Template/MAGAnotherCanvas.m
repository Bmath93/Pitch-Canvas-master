//
//  MAGAnotherCanvas.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 3/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGAnotherCanvas.h"

#import <VVOSC/VVOSC.h>
#import <VVOSC/OSCManager.h>
#import <VVOSC/OSCInPort.h>
#import <VVOSC/OSCOutPort.h>
#import <VVOSC/OSCMessage.h>
#import <VVOSC/OSCAddressSpace.h>
#import <VVOSC/OSCNode.h>

@interface MAGAnotherCanvas()

@property OSCManager *manager;
@property OSCOutPort *outport;

@end

@implementation MAGAnotherCanvas

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"called viewDidLoad");
    
    self.manager = [[OSCManager alloc] init];
    [self.manager setDelegate:self];
    
    self.outport = [self.manager createNewOutputToAddress:@"localhost" atPort:2801];
    //[self.manager createNewInputForPort:2800];
    
    // get the OSC address space
    OSCAddressSpace *as = [OSCAddressSpace mainAddressSpace];
    
    
    // dispatch an OSC message received from an OSCInPort to the address space
    //[as dispatchMessage:receivedMessage];
    
    // find/create a node in the address space
    OSCNode *myNode = [as findNodeForAddress:@"/Address/Path/1" createIfMissing:YES];
    
    // add myself to the node's delegates so i get informed of data passed to the node
    [myNode addDelegate:self];
}

- (IBAction)sendMessage1:(id)sender {
    OSCMessage *newMsg = [OSCMessage createWithAddress:@"/Address/Path/1"];
    [newMsg addFloat:12.34];
    [self.outport sendThisMessage:newMsg];
}

- (IBAction)sendMessage2:(id)sender {
    OSCMessage *newMsg = [OSCMessage createWithAddress:@"/Address/Path/1"];
    [newMsg addFloat:12.33];
    [self.outport sendThisMessage:newMsg];
}

@end
