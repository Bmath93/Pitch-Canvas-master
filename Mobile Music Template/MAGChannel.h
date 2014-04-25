//
//  MAGChannel.h
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITouch.h>
#import "MAGPdButler.h"
#import "MAGSample.h"

@interface MAGChannel : NSObject

@property MAGSample *currentSample;

@property UITouch *currentTouch;
@property BOOL isOpen;

-(id) initWithButler:(MAGPdButler*)aButler andNum:(int)myChannelNum;

-(void) sendFreq:(float)freq;
-(void) sendGain:(float)gain;
-(void) sendRev:(float)rev;

-(float) giveVelocity:(MAGSample *)incomingSample;

@end