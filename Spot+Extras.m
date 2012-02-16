//
//  Spot+Extras.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "Spot+Extras.h"
#import "SSCLController.h"

@implementation Spot (Extras)

-(void) getReviewsWithDelegate:(id) theDelegate 
                finishSelector:(SEL) success 
               failureSelector:(SEL) failure {
    
}


-(void) getTipsWithDelegate:(id) theDelegate 
             finishSelector:(SEL) success 
            failureSelector:(SEL) failure {
    
}


+(void) synchWithArrayOfDicts:(NSArray *) arrayOfDicts {
    
}

-(float) getDistanceFromHere {
    return [self distanceInMFromCoord:[[SSCLController sharedSSCLController] searchCenter]];
}

-(float)distanceInMFromCoord:(CLLocationCoordinate2D) coordinate {
	if (!self.lat) {
		return -1;
	}
	Haversine *haversine = [[[Haversine alloc] initWithLat1:coordinate.latitude
                                                       lon1:coordinate.longitude
                                                       lat2:[self.lat floatValue] 
                                                       lon2:[self.lng floatValue]] autorelease];
	return [haversine toMeters];
}

- (NSComparisonResult) sortByDistance:(Spot *)object2  {
    if ([self getDistanceFromHere] > [object2 getDistanceFromHere]) {
        return NSOrderedDescending;
    } else {
        return NSOrderedAscending;
    }
}
-(NSComparisonResult) sortByRating:(Spot *) object2 {
    return [[self star_rating] compare:[object2 star_rating]];
}

-(NSComparisonResult) sortByName:(Spot *) object2 {
    return [[self name] compare:[object2 name]];
}


@end
