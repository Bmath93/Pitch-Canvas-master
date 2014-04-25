//
//  MAGAppDelegate.h
//  Mobile Music Template
//
//  Created by Jesse Allison on 10/17/12.
//  Copyright (c) 2012 MAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdAudioController.h"
#import <CoreMotion/CoreMotion.h>
#import "MAGTopViewController.h"

@class MAGViewController;

@interface MAGAppDelegate : UIResponder <UIApplicationDelegate> {
    
    CMMotionManager *motionManager;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MAGTopViewController *topViewController;
@property (nonatomic, strong,readonly) PdAudioController *audioController;
@property (readonly) CMMotionManager *motionManager;


@end
