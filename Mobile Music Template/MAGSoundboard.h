//
//  MAGSoundboard.h
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MAGSample.h"
#import "UIKit/UITouch.h"
#import "MAGChannel.h"
#import "MAGCircleArray.h"
#import "MAGPdButler.h"

@interface MAGSoundboard : NSObject

@property (strong, nonatomic) NSMutableArray *gestureArray;

@property (weak, nonatomic) MAGCircleArray *circles;

- (id)initEmptyArrayWithCircles:(MAGCircleArray *)someCircles andButler:(MAGPdButler*)aButler;

-(void) sendBeganLocation:(CGPoint)location withTouchID:(UITouch*)touch;
-(void) sendMovedLocation:(CGPoint)location fromTouch:(UITouch*)touch;
-(void) sendEndedFromTouch:(UITouch*)touch;

@end