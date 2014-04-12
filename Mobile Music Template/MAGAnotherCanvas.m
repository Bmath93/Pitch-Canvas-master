//
//  MAGAnotherCanvas.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 3/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGAnotherCanvas.h"


@interface MAGAnotherCanvas()

@property (weak, nonatomic) IBOutlet UILabel *gestureStorageLabel1;

@property F53OSCServer *oscServer;
@property F53OSCClient *oscClient;

@end

@implementation MAGAnotherCanvas

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //initialize all of the OSC objects
    self.oscClient = [[F53OSCClient alloc] init];
    /*
    NSArray *arguments1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
    NSArray *arguments2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], nil];
    self.message1 = [F53OSCMessage messageWithAddressPattern:@"/path1/message1"
                                                   arguments:arguments1];
    self.message2 = [F53OSCMessage messageWithAddressPattern:@"/path1/message2"
                                                   arguments:arguments2];
    */
    
    //finish setting up the OSC server
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:self.userPort];
    [self.oscServer setDelegate:self];
    BOOL success = [self.oscServer startListening];
    if (success){NSLog(@"success");}
    else{NSLog(@"failure");};
    
    /*
    NSLog(self.userAddress);
    NSLog(@"%i",self.userPort);
    NSLog(@"called viewDidLoad");
     */
}

/*
- (IBAction)sendMessage1:(id)sender {
    [self.oscClient sendPacket:self.message1 toHost:self.userAddress onPort:self.userPort];
    
}
*/
- (IBAction)recordNextGesture1:(id)sender {
    //send to the other device a message indicating that the next gesture should be recorded and transmitted across
    [self.oscClient sendPacket:[    F53OSCMessage messageWithAddressPattern:@"/Canvas/gestureRequest1"
                                                                  arguments:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], nil]]
                        toHost:self.userAddress
                        onPort:self.userPort];
}

- (void)takeMessage:(F53OSCMessage *)message {
    //NSLog(@"in takeMessage:message");
    NSString *addressPattern = message.addressPattern;
    NSArray *arguments = message.arguments;
    /*
    NSNumber *receivedInt = [arguments objectAtIndex:0];
    //NSLog(@"%i",[receivedInt intValue]);
    [self changeMessageDisplayLabelTo:[receivedInt intValue]];
    if ([addressPattern isEqualToString:@"/path1/message1"]){
        NSLog(@"intercepted message1");
    }
    else if ([addressPattern isEqualToString:@"/path1/message2"]){
        NSLog(@"intercepted message2");
    }
     */
    if ([addressPattern isEqualToString:@"/TandemCanvas1/Gesture1"]){
        //finish implementing the initFromArray method in MAGGesture and use here
    }
}

- (IBAction)playCurrentGestureUponNextTouch1:(id)sender {
}

/*
-(void) changeMessageDisplayLabelTo:(int)recievedInt{
    NSString *newTextString = [NSString stringWithFormat:@"%i",recievedInt];
    [self.receivedTextLabel setText:newTextString];
}
*/
@end
