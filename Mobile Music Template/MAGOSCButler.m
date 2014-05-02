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
    
    if ([addressPattern isEqualToString:@"/path1/message1"]){
        NSLog(@"%i",[[arguments objectAtIndex:0] intValue]);
        self.receivedNumber = [[arguments objectAtIndex:0] intValue];
    }
}

-(void)sendNumber:(int)aNumber{
    NSArray *arguments1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:aNumber], nil];
    F53OSCMessage *message1 = [F53OSCMessage messageWithAddressPattern:@"/path1/message1"
                                                   arguments:arguments1];
    [self.oscClient sendPacket:message1 toHost:self.address onPort:self.sendPortNumber];
}

@end