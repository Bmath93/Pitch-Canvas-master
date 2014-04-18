//
//  MAGPdButler.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGPdButler.h"

@interface MAGPdButler ()



@end

@implementation MAGPdButler

- (id) init{
    self = [super init];
    
    // _________________ LOAD Pd Patch ____________________
    dispatcher = [[PdDispatcher alloc] init];
    [PdBase setDelegate:dispatcher];
    patch = [PdBase openFile:@"mag_template.pd" path:[[NSBundle mainBundle] resourcePath]];
    if (!patch) {
        NSLog(@"Failed to open patch!");
    }
    
    return self;
}

- (void) sendFloat:(float)num toReceiver:(NSString *)receiverName{
    [PdBase sendFloat:num toReceiver:receiverName];
}

@end
