//
//  MAGCanvas.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGCanvas.h"

@interface MAGCanvas ()

@property (strong, nonatomic) MAGCircleArray *circles;

@end

@implementation MAGCanvas

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.circles = [[MAGCircleArray alloc] initWithRadius:self.circleSize andPitch:self.baseKey andShift:self.shift andMultipleKeys:self.multipleKeys];
    self.theSoundboard = [[MAGSoundboard alloc] initEmptyArrayWithCircles:self.circles andButler:self.pdButler];
    /*self.theBackground.circles = self.circles;
     self.theBackground.allGestures = self.sampleHandler.gestureArray;
     [self.theBackground setNeedsDisplay];*/
}

- (void)viewDidUnload {
    //[self setTheBackground:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 0)
    {
        for (UITouch *touch in touches)
        {
            if (touch.phase == UITouchPhaseBegan)
            {
                
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 0)
    {
        for (UITouch *touch in touches)
        {
            /*if (touch.phase == UITouchPhaseMoved)
            {
                
            }*/
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 0)
    {
        for (UITouch *touch in touches)
        {
            if (touch.phase == UITouchPhaseEnded)
            {
                
            }
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 0)
    {
        for (UITouch *touch in touches)
        {
            if (touch.phase == UITouchPhaseCancelled)
            {
                
            }
        }
    }
}

@end
