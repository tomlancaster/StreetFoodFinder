//
//  Spot+Extras.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "Spot.h"
#import "Haversine.h"

@interface Spot (Extras)

-(void) getReviewsWithDelegate:(id) theDelegate 
                finishSelector:(SEL) success 
               failureSelector:(SEL) failure;


-(void) getTipsWithDelegate:(id) theDelegate 
                finishSelector:(SEL) success 
            failureSelector:(SEL) failure;




+(void) synchWithArrayOfDicts:(NSArray *) arrayOfDicts;


-(float)distanceInMFromCoord:(CLLocationCoordinate2D) coordinate;

-(float) getDistanceFromHere;
- (NSComparisonResult) sortByDistance:(Spot *)object1;
- (NSComparisonResult) sortByRating:(Spot *) object2;
- (NSComparisonResult) sortByName:(Spot *) object2;

@end
