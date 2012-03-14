//
//  Spot+Extras.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "Spot+Extras.h"
#import "SSCLController.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ApplicationDataService.h"
#import "NSManagedObject+NSObject.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "Review.h"
#import "Review+Extras.h"

@implementation Spot (Extras)

+ (void) getReviewsForSpotId:(NSNumber *) spotId 
                       delegate:(id) theDelegate 
                finishSelector:(SEL) success 
               failureSelector:(SEL) failure {
    NSString *path = [NSString stringWithFormat:@"/en/venue/reviews?venue_id=%@&sort=0&json=1&app_version=%@&origin=iphone", spotId, @"3"];
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:path] autorelease];
    [request createGetWithDict:nil andDelegate:theDelegate finishSelector:success failureSelector:failure];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.queue addOperation:request];
}

-(void) getTipsWithDelegate:(id) theDelegate 
             finishSelector:(SEL) success 
            failureSelector:(SEL) failure {
  

}

+ (void) didGetReviews:(ASIHTTPRequest *) request {
    if ([request responseStatusCode] != 200) {
        DLog(@"failed request");
        return;
    } else {
        [self syncReviewsFromResponse:[request responseString]];
    }
}

+ (void) requestFailed:(ASIHTTPRequest *)request {
    DLog(@"Foo");
}


+ (void) syncReviewsFromResponse:(NSString *) response {
    ApplicationDataService *ADS = [[[ApplicationDataService  alloc] initWithIdName:@"review_id" entityName:@"Review"] autorelease];
    ApplicationDataService *spotADS = [[[ApplicationDataService alloc] initWithIdName:@"spot_id" entityName:@"Spot"] autorelease];
    NSDictionary *responseArray = [response objectFromJSONString];
    for (NSDictionary *reviewDict in responseArray) {
        Review *review = [ADS getLocalById:[reviewDict objectForKey:@"web_id"]];
        if (review == nil) {
            review = [[NSManagedObjectContext defaultManagedObjectContext] insertNewObjectForEntityWithName:@"Review"];
        }
        [review safeSetValuesForKeysWithDictionary:reviewDict dateFormatter:nil];
        
        review.spot = [spotADS getLocalById:review.spot_id];
        review.username = [reviewDict valueForKey:@"userName"];
       
        
    }
    
    NSError *error = nil;
	if (![[NSManagedObjectContext defaultManagedObjectContext] save:&error]) {
		//DLog(@"unable to save local %@", [self class]);
		DLog(@"error: %@", [error localizedDescription]);
		
		if (error != nil) {
			// [error retain];
			DLog(@"Failed to save merged  %@", [error localizedDescription]);
			NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
			if(detailedErrors != nil && [detailedErrors count] > 0) {
				for(NSError* detailedError in detailedErrors) {
					DLog(@"  DetailedError: %@", [detailedError userInfo]);
				}
			}
			else {
				DLog(@"  %@", [error userInfo]);
				
			}
		}
		//return nil;
		
	}
    
    DLog(@"Got past reviews save");
    
}

-(void) synchWithArrayOfDicts:(NSArray *) arrayOfDicts {
    
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
    if ([[self star_rating] intValue] > [[object2 star_rating] intValue]) {
        return NSOrderedAscending;
    } else {
        return NSOrderedDescending;
    }
}

-(NSComparisonResult) sortByName:(Spot *) object2 {
    return [[self name] compare:[object2 name]];
}


@end
