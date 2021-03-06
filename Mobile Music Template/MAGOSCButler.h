//
//  MAGOSCButler.h
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/26/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "F53OSC.h"

@interface MAGOSCButler : NSObject <F53OSCPacketDestination>

@property BOOL shouldRecordNextGesture;
@property int sendPortNumber;
@property int receivedNumber;

-(id) initToAddress:(NSString*)address onPort:(int)portNumber;

-(void) sendNumber:(int)aNumber;

@end
