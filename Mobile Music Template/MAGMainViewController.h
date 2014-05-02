//
//  MAGMainViewController.h
//  Mobile Music Template
//
//  Created by MillTwo on 7/19/13.
//  Copyright (c) 2013 MAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGPdButler.h"
#import "MAGOSCButler.h"

@interface MAGMainViewController : UIViewController

@property (weak, nonatomic) MAGOSCButler *oscButler;
@property MAGPdButler *pdButler;

@end
