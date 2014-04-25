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

//@property (strong, nonatomic) NSMutableArray *gestureArray;

@property (weak, nonatomic) MAGCircleArray *circles;

- (id)initWithCircles:(MAGCircleArray *)someCircles andButler:(MAGPdButler*)aButler;

-(void) handleBeganLocation:(CGPoint)location withTouchID:(UITouch*)touch;
-(void) handleMovedLocation:(CGPoint)location fromTouch:(UITouch*)touch;
-(void) handleEndedFromTouch:(UITouch*)touch;

@end