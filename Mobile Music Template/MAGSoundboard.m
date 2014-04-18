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

- (id)initEmptyArrayWithCircles:(MAGCircleArray *)someCircles andButler:(MAGPdButler*)aButler{
    self = [super init];
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

-(void) sendBeganLocation:(CGPoint)location withTouchID:(UITouch*)touch{
    BOOL shouldAssign = TRUE;
    for (MAGChannel* channel in self.allChannels)
    {
        if (channel.isOpen && shouldAssign) {
            //grab frequency from pitchMap. send freq & rev with vol=0.5 to channel to send to pd. assign channel the current touch id, set channel.isOpen to false.
            shouldAssign = FALSE;
        }
    }
}

-(void) sendMovedLocation:(CGPoint)location fromTouch:(UITouch*)touch{
    for (MAGChannel* channel in self.allChannels)
    {
        if ([touch isEqual:channel.currentTouch]){
            //grab frequency from pitchMap. calculate touch velocity using the currentSample info stored in the channel. send freq, vol, and rev to channel to send to pd.
        }
    }
}

-(void) sendEndedFromTouch:(UITouch*)touch{
    for (MAGChannel* channel in self.allChannels)
    {
        if ([touch isEqual:channel.currentTouch]){
            //send vol=0 to channel to send to pd. set channel.isOpen to true.
        }
    }
}

@end
