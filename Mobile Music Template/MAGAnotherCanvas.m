//
//  MAGAnotherCanvas.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 3/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGAnotherCanvas.h"


@interface MAGAnotherCanvas()

- (void)changeMessageDisplayLabelTo: (int)recievedInt;

@property (weak, nonatomic) IBOutlet UILabel *receivedTextLabel;
/*
@property F53OSCServer *oscServer;
@property F53OSCClient *oscClient;
@property F53OSCMessage *message1;
@property F53OSCMessage *message2;
*/
@end

@implementation MAGAnotherCanvas

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    //initialize all of the OSC objects
    self.oscClient = [[F53OSCClient alloc] init];
    NSArray *arguments1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
    NSArray *arguments2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], nil];
    self.message1 = [F53OSCMessage messageWithAddressPattern:@"/path1/message1"
                                                   arguments:arguments1];
    self.message2 = [F53OSCMessage messageWithAddressPattern:@"/path1/message2"
                                                   arguments:arguments2];
    */
    /*
    //finish setting up the OSC server
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:self.userPort];
    [self.oscServer setDelegate:self];
    BOOL success = [self.oscServer startListening];
    if (success){NSLog(@"success");}
    else{NSLog(@"failure");};
    */
    NSLog(self.userAddress);
    NSLog(@"%i",self.userPort);
    NSLog(@"called viewDidLoad");
}

- (IBAction)sendMessage1:(id)sender {
    NSLog(@"message1 sent");
    /*
    [self.oscClient sendPacket:self.message1 toHost:self.userAddress onPort:self.userPort];
     */
}

- (IBAction)sendMessage2:(id)sender {
    /*
    [self.oscClient sendPacket:self.message2 toHost:self.userAddress onPort:self.userPort];
     */
}
/*
- (void)takeMessage:(F53OSCMessage *)message {
    NSLog(@"in takeMessage:message");
    NSString *addressPattern = message.addressPattern;
    NSArray *arguments = message.arguments;
    NSNumber *receivedInt = [arguments objectAtIndex:0];
    NSLog(@"%i",[receivedInt intValue]);
    [self changeMessageDisplayLabelTo:[receivedInt intValue]];
    if ([addressPattern isEqualToString:@"/path1/message1"]){
        NSLog(@"intercepted message1");
    }
    else if ([addressPattern isEqualToString:@"/path1/message2"]){
        NSLog(@"intercepted message2");
    }
}
*/
-(void) changeMessageDisplayLabelTo:(int)recievedInt{
    NSString *newTextString = [NSString stringWithFormat:@"%i",recievedInt];
    [self.receivedTextLabel setText:newTextString];
}

@end
