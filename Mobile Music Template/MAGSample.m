//
//  MAGSample.m
//  Mobile Music Template
//
//  Created by MillTwo on 7/4/13.
//  Copyright (c) 2013 MAG. All rights reserved.
//

#import "MAGSample.h"

@implementation MAGSample

@synthesize location = _location;
@synthesize time = _time;
@synthesize wasFirstSample = _wasFirstSample;
@synthesize wasLastSample = _wasLastSample;

//probably obsolete in restructuring
- (id)initWithLocation:(CGPoint)sampleLocation andTime:(NSDate *)sampleTime andFirstSample:(BOOL)wasFirstSample andLastSample:(BOOL)wasLastSample
{
    self = [super init];
    
    if(self)
    {
        _location = CGPointMake(sampleLocation.x,sampleLocation.y);
        _time = sampleTime.copy;
        _wasFirstSample = wasFirstSample;
        _wasLastSample = wasLastSample;
    }
    return self;
}

- (id) initWithLocation:(CGPoint)sampleLocation andTime:(NSDate *)sampleTime
{
    self = [super init];
    
    if(self)
    {
        _location = CGPointMake(sampleLocation.x,sampleLocation.y);
        _time = sampleTime.copy;
    }
    return self;
}


- (float)distanceFromSample:(MAGSample *)otherSample
{
    return sqrt( pow(self.location.x-otherSample.location.x,2) + pow(self.location.y-otherSample.location.y,2) );
}

- (float)secondsSinceSample:(MAGSample *)otherSample
{
    return [self.time timeIntervalSinceDate:otherSample.time];
}

@end
