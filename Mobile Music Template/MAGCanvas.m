//
//  MAGCanvas.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGCanvas.h"

@interface MAGCanvas ()

@property (weak, nonatomic) IBOutlet MAGBackground *theBackground;

@end

@implementation MAGCanvas

-(void) viewDidLoad{
    [super viewDidLoad];
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0/10.0;
    
    
    [self initializeAttributes];
}

- (void)viewDidUnload {
    //[self setTheBackground:nil];
    [super viewDidUnload];
}

- (void) initializeAttributes{
    MAGCircleArray *theCircles = [[MAGCircleArray alloc] initWithRadius:self.circleSize andPitch:self.baseKey andShift:self.shift andMultipleKeys:self.multipleKeys];
    if (theCircles == nil){
        NSLog(@"theCircles is nil");
    }
    self.theSoundboard = [[MAGSoundboard alloc] initWithCircles: theCircles andButler:self.pdButler];
    self.theBackground.circles = theCircles;
    if (self.theSoundboard.circles == nil){
        NSLog(@"self.theSoundboard.circles is nil");
    }
    if (self.theBackground.circles == nil){
        NSLog(@"self.theBackground.circles is nil");
    }
    [self.theBackground setNeedsDisplay];
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
                [self.theSoundboard handleBeganLocation:[touch locationInView:touch.view]
                                            withTouchID:touch];
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
            if (touch.phase == UITouchPhaseMoved)
            {
                [self.theSoundboard handleMovedLocation:[touch locationInView:touch.view] fromTouch:touch];
            }
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
                [self.theSoundboard handleEndedFromTouch:touch];
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

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self startAccelerometerData];
    
}

- (void)startAccelerometerData{
    //__block float stepMoveFactor = 15;
    
    [self.motionManager
     startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
     withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            //[self.theSoundboard handleAccelerometerDataX:data.acceleration.x];
                            [self.theSoundboard handleAccelerometerDataY:data.acceleration.y];
                            //[self.theSoundboard handleAccelerometerDataZ:data.acceleration.z];
                            //NSLog(@"%f",data.acceleration.y);
                        }
                        );
     }
     ];
    
}

@end
