//
//  MAGCircleArray.m
//  Mobile Music Template
//
//  Created by MillTwo on 7/4/13.
//  Copyright (c) 2013 MAG. All rights reserved.
//

#import "MAGCircleArray.h"
#import "MAGCircle.h"

@implementation MAGCircleArray

@synthesize circleArray = _circleArray;

@synthesize pitchMap = _pitchMap;

- (id)initWithRadius:(float)circleRadius andPitch:(float)startingPitch andShift:(int)shift andMultipleKeys: (int)multipleKeys
{
    //NSLog(@"initializing a MAGCircleArray");
    self = [super init];
    
    //string used to check the user preferences
    NSString *keyString = [NSString stringWithFormat:@"pitchMapWithRadius%fandStartingPitch%fandShift:%iandMultipleKeys%i",circleRadius,startingPitch,shift,multipleKeys];
    
    //initializing self.circleArray
    //will be a two-dimensional matrix of circles
    //the point (0,0) refers to the top-left pixel on the screen
    
    BOOL centerAboveScreen = TRUE; //boolean describing whether or not the current column of circles begins with the first circle's center above the end of the screen
    float altitude = sqrt(3.0)/2.0*circleRadius;
    NSMutableArray *aboveScreenPitches = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:21.0],
                                   [NSNumber numberWithFloat:17.0],
                                   [NSNumber numberWithFloat:14.0],
                                   [NSNumber numberWithFloat:11.0],
                                   [NSNumber numberWithFloat:7.0],
                                   [NSNumber numberWithFloat:4.0],
                                   [NSNumber numberWithFloat:0.0],nil];
    int aspFourthIndex = 1; //index of note in aboveScreenPitches that is a perfect fourth from the tonic
    
    NSMutableArray *notAboveScreenPitches = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithFloat:23.0],
                                      [NSNumber numberWithFloat:19.0],
                                      [NSNumber numberWithFloat:16.0],
                                      [NSNumber numberWithFloat:12.0],
                                      [NSNumber numberWithFloat:9.0],
                                      [NSNumber numberWithFloat:5.0],
                                      [NSNumber numberWithFloat:2.0],nil];
    int naspFourthIndex = 5; //index of note in notAboveScreenPitches that is a perfect fourth from the tonic
    
    NSMutableArray *futureCircles = [[NSMutableArray alloc] init];
    CGPoint currentCenter = CGPointMake(0.0, circleRadius/2.0);
    
    if (multipleKeys == 1){startingPitch = startingPitch + 17.0; shift = shift + 5;}
    int pitchCounter = shift;
    int circleColumn = 0;
    //int shiftCounter = 1;
    float pitchBase = startingPitch;
    NSNumber *currentPitch = [NSNumber numberWithFloat:0.0];
    while (currentCenter.x < 768+circleRadius*2.0)
    {
        //NSLog(@"%f",currentCenter.x/(2.0*altitude));
        //create a new array for this column of circles
        NSMutableArray *columnCircles = [[NSMutableArray alloc] init];
        
        while (currentCenter.y < 1024+circleRadius*2.0) {
            //find the pitch of the current circle
            if (centerAboveScreen)
            {
                currentPitch = [NSNumber numberWithFloat:pitchBase + [aboveScreenPitches[pitchCounter] floatValue]];
            }
            else
            {
                currentPitch = [NSNumber numberWithFloat:pitchBase + [notAboveScreenPitches[pitchCounter] floatValue]];
            }
            pitchCounter = pitchCounter + 1;
            if (pitchCounter==aboveScreenPitches.count) {pitchCounter = pitchCounter - aboveScreenPitches.count; pitchBase = pitchBase - 24;}
            [columnCircles addObject:[[MAGCircle alloc] initWithCenter:currentCenter Radius:circleRadius Pitch:currentPitch.floatValue]];
            
            //increment currentCenter.y
            currentCenter.y = currentCenter.y + 2.0*circleRadius;
        }
        
        //add the new array to futureCircles
        [futureCircles addObject:columnCircles];
        
        //increment currentCenter.x
        currentCenter.x = currentCenter.x + 2.0*altitude;
        if (centerAboveScreen)
        {
            centerAboveScreen = FALSE;
            currentCenter.y = -circleRadius/2.0;
            pitchCounter = shift;
            pitchBase = startingPitch;
            circleColumn = (int )(currentCenter.x/(2.0*altitude));
            //NSLog(@"%i",circleColumn);
            
            //enable mulitple scales
                if ( (multipleKeys == 1) && ((circleColumn == 3) || (circleColumn ==7)) )
                {
                    //sharp the fourth to change the key
                    [aboveScreenPitches replaceObjectAtIndex:aspFourthIndex withObject:[NSNumber numberWithFloat:[[aboveScreenPitches objectAtIndex:aspFourthIndex] floatValue] + 1.0]];
                    [notAboveScreenPitches replaceObjectAtIndex:naspFourthIndex withObject:[NSNumber numberWithFloat:[[notAboveScreenPitches objectAtIndex:naspFourthIndex] floatValue] + 1.0]];
                    
                    //find the index of the fourth in the new key
                    aspFourthIndex = aspFourthIndex - 2;
                    naspFourthIndex = naspFourthIndex - 2;
                
                    //make sure the indeces are above zero, correct if otherwise
                    if (aspFourthIndex < 0) {
                        aspFourthIndex = aspFourthIndex + aboveScreenPitches.count;
                    }
                    if (naspFourthIndex < 0) {
                        naspFourthIndex = naspFourthIndex + notAboveScreenPitches.count;
                    }
                }
            
        }
        else
        {
            centerAboveScreen = TRUE;
            currentCenter.y = circleRadius/2.0;
            pitchCounter = shift;
            pitchBase = startingPitch;
        }
    }
    _circleArray = [[NSArray alloc] initWithArray:futureCircles];
    //NSLog(@"initialized self.circleArray");
    //NSLog(@"self.circleArray.count: %i",self.circleArray.count);
    //NSLog(@"self.circleArray[0].count: %i",[[self.circleArray objectAtIndex:0] count]);
    //NSLog(@"self.circleArray[1].count: %i",[[self.circleArray objectAtIndex:1] count]);
    //NSLog(@"currentPitch: %f, circleRadius: %f",[[[[futureCircles objectAtIndex:0] objectAtIndex:0] pitch] floatValue],[[[[futureCircles lastObject] lastObject] radius] floatValue]);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *previousMapKey = [prefs stringForKey:@"previous map"];
    NSArray *thePitchMap = [[NSArray alloc] init];
    if ([previousMapKey isEqualToString:keyString])
    {
        NSLog(@"same as previous settings.  reloading pitchMap");
        thePitchMap = [prefs arrayForKey:keyString];
    }
    else
    {
        NSLog(@"settings different from previously");
        
        if (previousMapKey != NULL)
        {
            NSLog(@"must delete");
            [prefs setObject:NULL forKey:previousMapKey];
        }
        
        //creating a matrix for the pitches in the triangular regions to be referred to later
        NSMutableArray *futurePitchMap = [[NSMutableArray alloc] init];
        //slidePitchReference stores the fractional contributions of the pitches of nearby circles (coefficients) to the current pixel's pitch.
        //slidePitchReference will have dimensions altitude by circleRadius by three, with the three-dimensional matrix stored in [relativePixelRow,relativePixelColumn] containing the three coefficients
        NSMutableArray *slidePitchReference = [[NSMutableArray alloc] init];
        //c1 = (0,-r/2)
        //c2 = (0,3r/2)
        //c3 = (2*altitude,r/2)
        CGPoint center1 = CGPointMake(0.0, -circleRadius/2.0);
        CGPoint center2 = CGPointMake(0.0,3*circleRadius/2.0);
        CGPoint center3 = CGPointMake(2.0*altitude, circleRadius/2.0);
        double d1 = 0.0;
        double d2 = 0.0;
        double d3 = 0.0;
        float p1Coefficient = 0.0;
        float p2Coefficient = 0.0;
        float p3Coefficient = 0.0;
        for (int xCounter = 0; xCounter <= (int)altitude; xCounter = xCounter + 1)
        {
            //add an array for each row in the box
            [slidePitchReference addObject:[[NSMutableArray alloc] init]];
            
            for (int yCounter = 0; yCounter <= (int) circleRadius; yCounter = yCounter + 1)
            {
                //in this section, adds a 1x3 array to slidePitchReference for each pixel in the box.
                //each element in this new array will be the fractional contribution of the pitches of the adjacent circles (coefficients) to the pitch of the current pixel
                
                //for each (x,y):
                //calculate its distance from the center of each circle
                d1 = sqrt( pow( center1.x - xCounter, 2)+pow( center1.y - yCounter, 2));
                d2 = sqrt( pow( center2.x - xCounter, 2)+pow( center2.y - yCounter, 2));
                d3 = sqrt( pow( center3.x - xCounter, 2)+pow( center3.y - yCounter, 2));
                
                //if the distance from a circle is less than the radius, that point gets that circle's pitch
                if (d1 < circleRadius) {
                    [slidePitchReference.lastObject addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:1.0], [NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:0.0],nil]];
                }
                else if (d2 < circleRadius) {
                    [slidePitchReference.lastObject addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:0.0],nil]];
                }
                else if (d3 < circleRadius) {
                    [slidePitchReference.lastObject addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:0.0], [NSNumber numberWithFloat:0.0],[NSNumber numberWithFloat:1.0],nil]];
                }
                else
                {
                    //find the contribution of the first circle
                    if (d2 < d3) //use the closer circle
                    {
                        p1Coefficient = [self giveFreqCoefficientForCircleCenter:center1 Radius:circleRadius atPoint:CGPointMake(xCounter, yCounter) closestToCircle:center2];
                    }
                    else
                    {
                        p1Coefficient = [self giveFreqCoefficientForCircleCenter:center1 Radius:circleRadius atPoint:CGPointMake(xCounter, yCounter) closestToCircle:center3];
                    }
                    
                    //find the contribution of the second circle
                    if (d1 < d3) //use the closer circle
                    {
                        p2Coefficient = [self giveFreqCoefficientForCircleCenter:center2 Radius:circleRadius atPoint:CGPointMake(xCounter, yCounter) closestToCircle:center1];
                    }
                    else
                    {
                        p2Coefficient = [self giveFreqCoefficientForCircleCenter:center2 Radius:circleRadius atPoint:CGPointMake(xCounter, yCounter) closestToCircle:center3];
                    }
                    
                    //find the contribution of the third circle
                    if (d1 < d2) //use the closer circle
                    {
                        p3Coefficient = [self giveFreqCoefficientForCircleCenter:center3 Radius:circleRadius atPoint:CGPointMake(xCounter, yCounter) closestToCircle:center1];
                    }
                    else
                    {
                        p3Coefficient = [self giveFreqCoefficientForCircleCenter:center3 Radius:circleRadius atPoint:CGPointMake(xCounter, yCounter) closestToCircle:center2];
                    }
                    
                    [slidePitchReference.lastObject addObject:[[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:p1Coefficient],[NSNumber numberWithFloat:p2Coefficient],[NSNumber numberWithFloat:p3Coefficient],nil]];
                }
            }
        }
        NSLog(@"slide pitch reference calculated");
        
        
        //iterate through the pixels, giving each pixel an empty pitch in the array
        for (int rowCounter = 0; rowCounter < 769; rowCounter = rowCounter + 1 ) {
            NSMutableArray *tempColumnPitches = [[NSMutableArray alloc] init];
            for (int columnCounter = 0; columnCounter < 1025; columnCounter = columnCounter + 1) {
                [tempColumnPitches addObject:[NSNumber numberWithFloat:0.0]];
            }
            [futurePitchMap addObject:tempColumnPitches];
        }
        NSLog(@"created empty futurePitchMap");
        
        BOOL isTriangle = FALSE;
        BOOL isFlipped = FALSE;
        NSMutableArray *relevantCircles = [[NSMutableArray alloc] init];
        //NSArray *currentCircleIndex = [[NSArray alloc] init];
        //NSArray *currentCircleColumn = [[NSArray alloc] init];
        
        MAGCircle *c1 = [[MAGCircle alloc] init];
        MAGCircle *c2 = [[MAGCircle alloc] init];
        MAGCircle *c3 = [[MAGCircle alloc] init];
        int tempHorizontalIndex = 0;
        int tempVerticalIndex = 0;
        float tempPitch = 0.0;
        NSArray *slidePitchForCurrentPixel = [[NSArray alloc] init];
        
        //NSLog(@"cell index:\tisTriangle:\tisFlipped:\trelevantCircles:");
        
        //view the screen as divided into cells of horizontal dimension altitude, and vertical dimension circleRadius
        //iterate through these cells, first in horizontally and then vertically
        //some cells will be entirely contained within a circle, and some will represent triangular regions
        for (int horizontalCellIndex = 0; horizontalCellIndex < 768/altitude; horizontalCellIndex = horizontalCellIndex + 1)
        {
            NSLog(@"currently initializing cells in column: %i",((int) altitude)*horizontalCellIndex);
            for (int verticalCellIndex = 0; verticalCellIndex < 1024/(circleRadius); verticalCellIndex = verticalCellIndex + 1)
            {
                //determine if the current cell is flipped relative to the cells in the first column. store in isFlipped
                if (horizontalCellIndex % 2 == 0){isFlipped = FALSE;}
                else if (horizontalCellIndex % 2 == 1){isFlipped = TRUE;}
                else {NSLog(@"error: horizontalCellIndex mod 2 != 0 or 1");}
                
                //determine if the current cell represents a triangular region. store in isTriangle
                if ((horizontalCellIndex%4 == 0) || (horizontalCellIndex%4 == 3))
                {
                    if (verticalCellIndex % 2 == 0){isTriangle = FALSE;}
                    else if (verticalCellIndex % 2 == 1){isTriangle = TRUE;}
                    else {NSLog(@"error: verticalCellIndex mod 2 != 0 or 1");}
                }
                else
                {
                    if ((verticalCellIndex+1) % 2 == 0) {isTriangle = FALSE;}
                    else if ((verticalCellIndex+1) % 2 == 1) {isTriangle = TRUE;}
                    else {NSLog(@"error: (verticalCellIndex+1) mod 2 != 0 or 1");}
                };
                
                //if the current cell is a triangle, find the relevant (adjacent) circles using the knowledge of the current cell index. calls the giveCircleForCellAt method
                if (isTriangle)
                {
                    if (horizontalCellIndex%4 == 0)
                    {
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex-1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex+1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex+1 and:verticalCellIndex]];
                    }
                    else if (horizontalCellIndex%4 == 1)
                    {
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex-1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex+1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex-1 and:verticalCellIndex]];
                    }
                    else if (horizontalCellIndex%4 == 2)
                    {
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex-1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex+1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex+1 and:verticalCellIndex]];
                    }
                    else if (horizontalCellIndex%4 == 3)
                    {
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex-1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex+1]];
                        [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex-1 and:verticalCellIndex]];
                    }
                }
                //if the current cell is not a triangle, find the circle containing this cell using the knowledge of the current cell location
                else
                {
                    [relevantCircles addObject:[self giveCircleForCellAt:horizontalCellIndex and:verticalCellIndex]];
                }
                
                //NSLog(@"c1x: %f, c1y: %f, c1.radius: %f, c1.pitch: %f",c1.center.x,c1.center.y,c1.radius.floatValue,c1.pitch.floatValue);
                
                //iterate throught the pixels stored in the current cell, first horizontally and then vertically
                for (int horizontalPixelIndex = 0; horizontalPixelIndex < altitude; horizontalPixelIndex = horizontalPixelIndex + 1)
                {
                    for (int verticalPixelIndex = 0; verticalPixelIndex < circleRadius; verticalPixelIndex = verticalPixelIndex + 1)
                    {
                        //tempHorizontalIndex stores the pixel's absolute horizontal location on the screen, and will be the row number of the pitch value stored in the final pitchMap
                        tempHorizontalIndex = horizontalCellIndex*((int) altitude)+horizontalPixelIndex;
                        
                        //tempVerticalIndex stores the pixel's absolute vertical location on the screen, and will be the column number of the pitch value stored in the final pitchMap
                        tempVerticalIndex = verticalCellIndex*circleRadius+verticalPixelIndex;
                        
                        //makesure the current pixel is on the screen. if not, ignore it.
                        if ((tempHorizontalIndex<769) && (tempVerticalIndex<1025))
                        {
                            //assign the first element (of type MAGCirlce) of relevantCirles to c1. relevantCircles gauranteed to have one element.
                            c1 = [[self.circleArray objectAtIndex:[[[relevantCircles objectAtIndex:0] objectAtIndex:0] intValue]] objectAtIndex:[[[relevantCircles objectAtIndex:0] objectAtIndex:1] intValue]];
                            
                            //if the current cell is a triangle:
                            if (isTriangle)
                            {
                                //if the current cell is flipped, grab the slidePitchReference coefficient matrix for the mirror pixel.
                                if (isFlipped)
                                {
                                    slidePitchForCurrentPixel = [[slidePitchReference objectAtIndex:(((int) altitude)-horizontalPixelIndex)] objectAtIndex:verticalPixelIndex];
                                }
                                //if the current cell is not flipped, grab the slidePitchReference coefficient matrix for the current pixel.
                                else
                                {
                                    slidePitchForCurrentPixel = [[slidePitchReference objectAtIndex:horizontalPixelIndex] objectAtIndex:verticalPixelIndex];
                                }
                                
                                //because the current cell is a triangle, relevantCircles must have three objects. assign the second and third elements (of type MAGCircle) to c2 and c3
                                c2 = [[self.circleArray objectAtIndex:[[[relevantCircles objectAtIndex:1] objectAtIndex:0] intValue]] objectAtIndex:[[[relevantCircles objectAtIndex:1] objectAtIndex:1] intValue]];
                                c3 = [[self.circleArray objectAtIndex:[[[relevantCircles objectAtIndex:2] objectAtIndex:0] intValue]] objectAtIndex:[[[relevantCircles objectAtIndex:2] objectAtIndex:1] intValue]];
                                
                                //grab the coefficients stored in slidePitchForCurrentPixel, assign to new variables
                                p1Coefficient = [[slidePitchForCurrentPixel objectAtIndex:0] floatValue];
                                p2Coefficient = [[slidePitchForCurrentPixel objectAtIndex:1] floatValue];
                                p3Coefficient = [[slidePitchForCurrentPixel objectAtIndex:2] floatValue];
                                
                                //calculate the pitch of the current pixel with the following formula:
                                tempPitch = (c1.pitch.floatValue*p1Coefficient + c2.pitch.floatValue*p2Coefficient + c3.pitch.floatValue*p3Coefficient)/(p1Coefficient+p2Coefficient+p3Coefficient);
                            }
                            
                            //if it's not a triangle, assign this pixel the same pitch as the that of the circle containing it.
                            else
                            {
                                tempPitch = c1.pitch.floatValue;
                            }
                            
                            //store the pitch for this pixel in futurePitchMap at the location [pixel's horizontal position on the screen][pixel's vertical position on the screen]
                            [[futurePitchMap objectAtIndex:tempHorizontalIndex] replaceObjectAtIndex:tempVerticalIndex withObject:[NSNumber numberWithFloat:tempPitch]];
                        }
                    }
                }
                
                //empty the array of relevant circles because the process is about to be repeated for a new pixel
                [relevantCircles removeAllObjects];
            }
        }
        //NSLog(@"saving the pitchMap");
        thePitchMap = futurePitchMap;
        [prefs setObject:keyString forKey:@"previous map"];
        [prefs setObject:thePitchMap forKey:keyString];
        [prefs synchronize];
        //NSLog(@"finished saving pitchMap");
    }
    
    _pitchMap = [[NSArray alloc] initWithArray:thePitchMap];
    
    return self;
}

- (NSArray *)giveCircleForCellAt:(int)horizontalCellIndex and:(int)verticalCellIndex
{
    NSMutableArray *circleCoordinates = [[NSMutableArray alloc] init];
    if (verticalCellIndex < 0) {verticalCellIndex = 0;}
    if (horizontalCellIndex % 4 == 0) {
        [circleCoordinates addObject:[NSNumber numberWithInt:horizontalCellIndex/2]];
        [circleCoordinates addObject:[NSNumber numberWithInt:verticalCellIndex/2]];
    }
    else if (horizontalCellIndex % 4 == 1)
    {
        [circleCoordinates addObject:[NSNumber numberWithInt:(horizontalCellIndex+1)/2]];
        [circleCoordinates addObject:[NSNumber numberWithInt:(verticalCellIndex+1)/2]];
    }
    else if (horizontalCellIndex % 4 == 2)
    {
        [circleCoordinates addObject:[NSNumber numberWithInt:horizontalCellIndex/2]];
        [circleCoordinates addObject:[NSNumber numberWithInt:(verticalCellIndex+1)/2]];
    }
    else if (horizontalCellIndex % 4 == 3)
    {
        [circleCoordinates addObject:[NSNumber numberWithInt:(horizontalCellIndex+1)/2]];
        [circleCoordinates addObject:[NSNumber numberWithInt:verticalCellIndex/2]];
    }
        return circleCoordinates;
}

- (float) giveFreqCoefficientForCircleCenter:(CGPoint)c1 Radius:(float)circleRadius atPoint:(CGPoint)point closestToCircle:(CGPoint)c2
{
    float slope = (point.y-c1.y)/(point.x-c1.x);
    float yIntercept = point.y - slope*point.x;
    
    float a = pow(slope,2.0) + 1.0;
    float b = 2.0*((yIntercept - c2.y)*slope - c2.x);
    float c = pow(c2.x,2.0) + pow(yIntercept - c2.y,2.0) - pow(circleRadius,2.0);
    
    float plusX = (-b + sqrt( pow(b,2.0) - 4.0*a*c))/(2.0*a);
    float minusX = (-b - sqrt( pow(b,2.0) - 4.0*a*c))/(2.0*a);
    float plusY = slope*plusX + yIntercept;
    float minusY = slope*minusX + yIntercept;
    
    float dCircleToPoint = [self distanceBetweenPointsP1:c1 andP2:point]-circleRadius;
    float dC1EdgeToC2Edge = 0.0;
    
    if ([self distanceBetweenPointsP1:CGPointMake(plusX, plusY) andP2:point] < [self distanceBetweenPointsP1:CGPointMake(minusX, minusY) andP2:point])
    {
        //use plusX and plusY
         dC1EdgeToC2Edge = [self distanceBetweenPointsP1:c1 andP2:CGPointMake(plusX, plusY)] - circleRadius;
    }
    else
    {
        //use minusX and minusY
        dC1EdgeToC2Edge = [self distanceBetweenPointsP1:c1 andP2:CGPointMake(minusX, minusY)] - circleRadius;
    }
    
    return (1.0 - dCircleToPoint/dC1EdgeToC2Edge);
}

- (float)distanceBetweenPointsP1:(CGPoint)p1 andP2:(CGPoint)p2
{
    return sqrt(pow(p1.x-p2.x,2.0) + pow(p1.y-p2.y,2.0));
}

@end