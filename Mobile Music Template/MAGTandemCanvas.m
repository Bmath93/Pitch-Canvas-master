//
//  MAGTandemCanvas.m
//  PitchCanvas
//
//  Created by Student Researcher on 2/21/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGTandemCanvas.h"
//#include "osc/OscOutboundPacketStream.h"
#include "osc/UdpSocket.h"

@implementation MAGTandemCanvas
- (IBAction)backToSetup:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)sendOSCstuff:(id)sender {
    
}



@end
