//
//  Spot+Extras.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "Spot.h"
#import "Haversine.h"
@class ASIHTTPRequest;

@interface Spot (Extras)

+ (void) getReviewsForSpotId:(NSNumber *) spotId 
                        delegate:(id) theDelegate 
                  finishSelector:(SEL) success 
                 failureSelector:(SEL) failure;


-(void) getTipsWithDelegate:(id) theDelegate 
                finishSelector:(SEL) success 
            failureSelector:(SEL) failure;



-(float)distanceInMFromCoord:(CLLocationCoordinate2D) coordinate;

-(float) getDistanceFromHere;
- (NSComparisonResult) sortByDistance:(Spot *)object1;
- (NSComparisonResult) sortByRating:(Spot *) object2;
- (NSComparisonResult) sortByName:(Spot *) object2;

+ (void) syncReviewsFromResponse:(NSString *) response;

+ (void) requestFailed:(ASIHTTPRequest *)request;

+ (void) didGetReviews:(ASIHTTPRequest *) request;

@end
