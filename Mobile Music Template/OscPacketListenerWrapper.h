//
//  OscPacketListenerWrapper.h
//  PitchCanvas
//
//  Created by Student Researcher on 2/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "ExampleOscListener.h"
#include "ExampleOscListener.cpp"

@interface OscPacketListenerWrapper : NSObject

@property ExampleOscListener *wrappedListener;

@end