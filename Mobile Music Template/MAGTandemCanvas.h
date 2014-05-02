//
//  MAGAnotherCanvas.h
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 3/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAGOSCButler.h"

@interface MAGTandemCanvas : UIViewController <F53OSCPacketDestination>

@property (weak, nonatomic) MAGOSCButler *oscButler;

@property int userPort;

@property NSString *userAddress;

@end
