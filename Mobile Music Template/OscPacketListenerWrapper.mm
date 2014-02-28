//
//  OscPacketListenerWrapper.m
//  PitchCanvas
//
//  Created by Student Researcher on 2/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "OscPacketListenerWrapper.h"
#include "ExampleOscListener.h"

@implementation OscPacketListenerWrapper
@synthesize wrappedListener = _wrappedListener;

- (id) init
{
    self = [super init];
    if (self)
    {
        _wrappedListener = new ExampleOscListener;
    }
    return self;
}

-(void) dealloc {
    delete _wrappedListener;
}

@end
