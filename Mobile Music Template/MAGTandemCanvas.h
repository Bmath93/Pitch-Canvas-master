//
//  MAGTandemCanvas.h
//  PitchCanvas
//
//  Created by Student Researcher on 2/21/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <VVOSC/VVOSC.h>
#import <VVOSC/OSCManager.h>
#import <VVOSC/OSCInPort.h>
#import <VVOSC/OSCOutPort.h>
#import <VVOSC/OSCMessage.h>

@interface MAGTandemCanvas : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *UpLabel;
@property (weak, nonatomic) IBOutlet UILabel *DownLabel;
@property OSCManager *manager;
@property OSCOutPort *outport;

@end
