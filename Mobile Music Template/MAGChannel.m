//
//  MAGChannel.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGChannel.h"

@interface MAGChannel ()

@property MAGPdButler *PdButler;

@property int channelNum;

@end

@implementation MAGChannel
@synthesize PdButler;

-(id) initWithButler:(MAGPdButler *)aButler andNum:(int)myChannelNum{
    self = [super init];
    
    self.PdButler = aButler;
    self.channelNum = myChannelNum;
    self.isOpen = TRUE;
    self.currentSample = NULL;
    self.currentTouch = NULL;
    
    return self;
}

-(void)sendFreq:(float)freq{
    [self.PdButler sendFloat:freq toReceiver:[NSString stringWithFormat:@"freq%i",self.channelNum]];
}
-(void)sendGain:(float)gain{
    if(gain > 0.125){gain = 0.125;}
    [self.PdButler sendFloat:gain toReceiver:[NSString stringWithFormat:@"gain%i",self.channelNum]];
}
-(void)sendRev:(float)rev{
    [self.PdButler sendFloat:rev toReceiver:[NSString stringWithFormat:@"rev%i",self.channelNum]];
}

-(float)giveVelocity:(MAGSample *)incomingSample{
    return [incomingSample distanceFromSample:self.currentSample]/[incomingSample secondsSinceSample:self.currentSample];
}

@end
