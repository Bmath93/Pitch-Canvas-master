//
//  MAGViewController.h
//  Mobile Music Template
//
//  Created by Jesse Allison on 10/17/12.
//  Copyright (c) 2012 MAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGCircle.h"
#import "MAGPdButler.h"

@interface MAGViewController : UIViewController

@property MAGPdButler *pdButler;

@property float baseKey;

@property int shift;

@property float circleSize;

@property int multipleKeys;

@end
