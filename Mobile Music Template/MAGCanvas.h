//
//  MAGCanvas.h
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <UIKit/Uikit.h>
#import <CoreMotion/CoreMotion.h>
#import "MAGCircleArray.h"
#import "MAGPdButler.h"
#import "MAGSoundboard.h"
#import "MAGBackground.h"

@interface MAGCanvas : UIViewController {
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

//needs a connection with the storyboard
//@property (strong, nonatomic) IBOutlet MAGBackground *theBackground;

@property MAGPdButler *pdButler;
@property MAGSoundboard *theSoundboard;

@property float baseKey;
@property int shift;
@property float circleSize;
@property int multipleKeys;

@end
