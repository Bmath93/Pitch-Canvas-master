//
//  MAGTandemCanvas.m
//  PitchCanvas
//
//  Created by Student Researcher on 2/21/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGTandemCanvas.h"
#include "osc/OscOutboundPacketStream.h"
#include "ip/UdpSocket.h"

#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"

#define ADDRESS "localhost"
#define PORT 7000

#define OUTPUT_BUFFER_SIZE 1024

@implementation MAGTandemCanvas

- (IBAction)backToSetup:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)sendOSCstuff:(id)sender {
    UdpTransmitSocket transmitSocket( IpEndpointName( ADDRESS, PORT ) );
    
    char buffer[OUTPUT_BUFFER_SIZE];
    osc::OutboundPacketStream p( buffer, OUTPUT_BUFFER_SIZE );
    
    p << osc::BeginBundleImmediate
    << osc::BeginMessage( "/test1" )
    << true << 23 << (float)3.1415 << "hello" << osc::EndMessage
    << osc::BeginMessage( "/test2" )
    << true << 24 << (float)10.8 << "world" << osc::EndMessage
    << osc::EndBundle;
    
    transmitSocket.Send( p.Data(), p.Size() );
}

@end
