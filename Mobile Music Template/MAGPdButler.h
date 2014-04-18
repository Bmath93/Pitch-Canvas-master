//
//  MAGPdButler.h
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdDispatcher.h"

@interface MAGPdButler : NSObject {
    PdDispatcher *dispatcher;
    void *patch;
}

- (id) init;

- (void) sendFloat:(float)num toReceiver:(NSString*)pathName;

@end
