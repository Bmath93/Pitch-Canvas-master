//
//  MAGOSCButler.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/26/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGOSCButler.h"

@interface MAGOSCButler ()

@property F53OSCServer *oscServer;
@property F53OSCClient *oscClient;
@property NSString *address;

@end

@implementation MAGOSCButler

-(id)initToAddress:(NSString *)anAddress onPort:(int)portNumber{
    self = [super init];
    
    self.oscClient = [[F53OSCClient alloc] init];
    
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:portNumber];
    [self.oscServer setDelegate:self];
    BOOL success = [self.oscServer startListening];
    if (success){NSLog(@"success");}
    else{NSLog(@"failure");};
    
    self.address = anAddress;
    return self;
}

-(void) takeMessage:(F53OSCMessage *)message{
    NSString *addressPattern = message.addressPattern;
    NSArray *arguments = message.arguments;
    if ([addressPattern isEqualToString:@"/Canvas/gestureRequest1"]){
        NSLog(@"%i",[[arguments objectAtIndex:0] intValue]);
        self.shouldRecordNextGesture = TRUE;
    }
}



@end
