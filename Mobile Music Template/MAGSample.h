//
//  MAGSample.h
//  Mobile Music Template
//
//  Created by MillTwo on 7/4/13.
//  Copyright (c) 2013 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MAGSample : NSObject

//probably obsolete in restructuring
- (id)initWithLocation:(CGPoint)sampleLocation andTime:(NSDate *)sampleTime andFirstSample:(BOOL)wasFirstSample andLastSample:(BOOL)wasLastSample;

- (id)initWithLocation:(CGPoint)sampleLocation andTime:(NSDate *)sampleTime;

- (float)distanceFromSample:(MAGSample *)otherSample;

- (float)secondsSinceSample:(MAGSample *)otherSample;

@property (strong,nonatomic) NSDate *time;

@property CGPoint location;

@end
