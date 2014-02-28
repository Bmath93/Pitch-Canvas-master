//
//  MAGOSCListener.m
//  PitchCanvas
//
//  Created by Student Researcher on 2/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGOSCListener.h"
#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"
#include "OscPacketListenerWrapper.h"
#define PORT 7000

@implementation MAGOSCListener

- (void) justListen{
    OscPacketListenerWrapper *listener;
    IpEndpointName myEndpoint = IpEndpointName(IpEndpointName::ANY_ADDRESS, PORT);
    UdpListeningReceiveSocket s = UdpListeningReceiveSocket(myEndpoint, listener.wrappedListener);
    s.RunUntilSigInt();
}


@end
