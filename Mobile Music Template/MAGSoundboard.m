//
//  MAGSoundboard.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGSoundboard.h"

@interface MAGSoundboard ()

@property NSArray *allChannels;

@end

@implementation MAGSoundboard

- (id)initWithCircles:(MAGCircleArray *)someCircles andButler:(MAGPdButler*)aButler{
    self = [super init];
    self.theButler = aButler;
    self.circles = someCircles;
    self.allChannels = [[NSArray alloc] initWithObjects:[[MAGChannel alloc] initWithButler:aButler andNum:1],
                        [[MAGChannel alloc] initWithButler:aButler andNum:2],
                        [[MAGChannel alloc] initWithButler:aButler andNum:3],
                        [[MAGChannel alloc] initWithButler:aButler andNum:4],
                        [[MAGChannel alloc] initWithButler:aButler andNum:5],
                        [[MAGChannel alloc] initWithButler:aButler andNum:6],
                        [[MAGChannel alloc] initWithButler:aButler andNum:7],
                        [[MAGChannel alloc] initWithButler:aButler andNum:8],nil];
    return self;
}

-(void) handleBeganLocation:(CGPoint)location withTouchID:(UITouch*)touch{
    MAGSample *incomingSample = [[MAGSample alloc] initWithLocation:location andTime:[[NSDate alloc] init]];
    
    BOOL shouldAssign = TRUE;
    for (MAGChannel* channel in self.allChannels)
    {
        if (channel.isOpen && shouldAssign) {
            //grab frequency from pitchMap. send freq & rev with vol=0.5 to channel to send to pd. assign channel the current touch id, set channel.isOpen to false. have channel store the new sample as the current sample
            
            //grab frequency from pitchMap.
            //have channel send the pitch to pd.
            [channel sendFreq: [ [ [self.circles.pitchMap objectAtIndex:incomingSample.location.x] objectAtIndex:incomingSample.location.y] floatValue] ];
            
            //have the channel send 0.01 to the volume
            [channel sendGain:0.01];
            
            //have the channel send the scaled x position to the reverb
            [channel sendRev:incomingSample.location.x/768.0];
            
            //tell the channel to remember this touch's id
            channel.currentTouch = touch;
            
            //store the current location and time information in the channel.
            channel.currentSample = incomingSample;
            
            //close the channel to incoming touches
            channel.isOpen = FALSE;
            
            //tell self to stop looking for an open channel to play this touch. equivalent to break.
            shouldAssign = FALSE;
        }
    }
}

-(void) handleMovedLocation:(CGPoint)location fromTouch:(UITouch*)touch{
    MAGSample *incomingSample = [[MAGSample alloc] initWithLocation:location andTime:[[NSDate alloc] init]];
    
    for (MAGChannel* channel in self.allChannels)
    {
        //check to see if the current channel is mapped to the current touch
        if ([touch isEqual:channel.currentTouch]){
            //grab frequency from pitchMap. calculate touch velocity using the currentSample info stored in the channel. send freq, vol, and rev to channel to send to pd. have channel store the new sample as the current sample.
            
            //grab frequency from pitchMap.
            //have channel send the pitch to pd.
            [channel sendFreq: [ [ [self.circles.pitchMap objectAtIndex:incomingSample.location.x] objectAtIndex:incomingSample.location.y] floatValue] ];
            
            //calculate touch velocity using the channel's currentSample info.
            //have the channel send the velocity to the gain receiver in pd.
            float velocity = [channel giveVelocity:incomingSample];
            [channel sendGain:velocity/1000.0];
            
            //have the channel send the scaled x position to the reverb
            [channel sendRev:incomingSample.location.x/768.0];
            
            //store the current location and time information in the channel.
            channel.currentSample = incomingSample;
        }
    }
}

-(void) handleEndedFromTouch:(UITouch*)touch{
    for (MAGChannel* channel in self.allChannels)
    {
        if ([touch isEqual:channel.currentTouch]){
            //send vol=0 to channel to send to pd. set channel.isOpen to true.
            
            //have channel send vol=0 to pd
            [channel sendGain:0.0];
            
            //re-open channel (allow it to receive a new touch id)
            channel.isOpen = TRUE;
        }
    }
}

-(void) handleAccelerometerDataX:(float)xTilt{
    float scaledGainValue = xTilt/2.0;
    [self setInitialTouchGain:scaledGainValue];
}
-(void) handleAccelerometerDataY:(float)yTilt{
    float scaledRevValue = ABS(yTilt)+0.1;
    if (scaledRevValue > 0.7) {scaledRevValue = 1.0;}
    [self setFullReverb:scaledRevValue];
}
-(void) handleAccelerometerDataZ:(float)zTilt{
    
}

-(void) setFullReverb:(float)revLevel{
    [self.theButler sendFloat:revLevel toReceiver:@"rev"];
}
-(void) setInitialTouchGain:(float)gainLevel{
    [self.theButler sendFloat:gainLevel toReceiver:@"initialGain"];
}

@end
