//
//  SpotCategory+Extras.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "SpotCategory+Extras.h"
#import "NSManagedObject+NSObject.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "ApplicationDataService.h"
#import "Spot.h"
#import "Spot+Extras.h"
#import "AppDelegate.h"
#import "Review+Extras.h"
#import "Review.h"
#import "ASIHTTPRequest.h"
#import "SSASIRequest.h"

@implementation SpotCategory (Extras)

+(void) getCategoriesWithDelegate:(id) theDelegate 
                   finishSelector:(SEL) success 
                  failureSelector:(SEL) failure {
    NSString *path = [NSString stringWithFormat:@"/venuecategory/get_json?venuecategory_id=%@", STREETFOODCAT];
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:path] autorelease];
    [request createGetWithDict:nil andDelegate:theDelegate finishSelector:success failureSelector:failure];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.queue addOperation:request];
    
    
}

+(void) getSpotsForCategoryId:(NSNumber *) catId 
                 withDelegate:(id) theDelegate 
              finishSelector:(SEL) success 
             failureSelector:(SEL) failure {
    NSString *path = [NSString stringWithFormat:@"/venuecategory/get_spots_json?venuecategory_id=%@", catId];
    DLog(@"path in get Spots: %@", path);
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:path] autorelease];
    [request createGetWithDict:nil andDelegate:theDelegate finishSelector:success failureSelector:failure];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.queue addOperation:request];
}

+ (void) syncSpotsFromResponse:(NSString *) response {
    
    ApplicationDataService *ADS = [[[ApplicationDataService alloc] initWithIdName:@"spot_id" entityName:@"Spot"] autorelease];
    ApplicationDataService *catADS = [[[ApplicationDataService alloc] initWithIdName:@"spotcategory_id" entityName:@"SpotCategory"] autorelease];
    ApplicationDataService *cityADS = [[[ApplicationDataService alloc] initWithIdName:@"city_id" entityName:@"City"] autorelease];
    
    NSDictionary *responseArray = [response objectFromJSONString];
    for (NSDictionary *spotDict in responseArray) {
        
        Spot *spot = [ADS getLocalById:[spotDict objectForKey:@"id"]];
        if (spot == nil) {
            spot = [[NSManagedObjectContext defaultManagedObjectContext] insertNewObjectForEntityWithName:@"Spot"];
        }
        spot.spot_id = [NSNumber numberWithInt:[[spotDict objectForKey:@"id"] intValue]];
        spot.address = IGNORE_NSNULL([spotDict objectForKey:@"address"]);
        spot.homepage = IGNORE_NSNULL([spotDict objectForKey:@"homepage"]);
        spot.name = IGNORE_NSNULL([spotDict objectForKey:@"name"]);
        spot.lat = [NSNumber numberWithFloat:[IGNORE_NSNULL([spotDict objectForKey:@"lat"]) floatValue]];
        spot.lng = [NSNumber numberWithFloat:[IGNORE_NSNULL([spotDict objectForKey:@"lng"]) floatValue]];
        spot.spotcategory_id = [NSNumber numberWithInt:[IGNORE_NSNULL([spotDict objectForKey:@"spotcategory_id"]) intValue]];
        spot.star_rating = [NSNumber numberWithFloat:[IGNORE_NSNULL([spotDict objectForKey:@"star_rating"]) floatValue]];
        spot.num_reviews = IGNORE_NSNULL([spotDict objectForKey:@"num_reviews"]);
        spot.city_id = [NSNumber numberWithInt:[IGNORE_NSNULL([spotDict objectForKey:@"city_id"]) intValue]];
        spot.city = [cityADS getLocalById:spot.city_id];
        spot.spot_category = [catADS getLocalById:spot.spotcategory_id];
        [Spot getReviewsForSpotId:spot.spot_id delegate:[Spot class] finishSelector:@selector(didGetReviews:) failureSelector:@selector(requestFailed:)];
       // DLog(@"spot category: %@", spot.spot_category);      
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
     
    DLog(@"Got past save");
    
}

+(void) syncFromResponse:(NSString *) response {
        
    ApplicationDataService *ADS = [[[ApplicationDataService alloc] initWithIdName:@"spotcategory_id" entityName:@"SpotCategory"] autorelease];
    
    
    NSDictionary *responseArray = [response objectFromJSONString];
    DLog(@"size of cats array: %d", [responseArray count]);
    for (NSDictionary *catDict in responseArray) {
        
        SpotCategory *cat = [ADS getLocalById:[catDict objectForKey:@"id"]];
        if (cat == nil) {
            cat = [[NSManagedObjectContext defaultManagedObjectContext] insertNewObjectForEntityWithName:@"SpotCategory"];
        }
        cat.spotcategory_id = [NSNumber numberWithInt:[[catDict objectForKey:@"id"] intValue]];
        cat.name_en_us = IGNORE_NSNULL([catDict objectForKey:@"name_en_us"]);
        cat.name_fr_fr = IGNORE_NSNULL([catDict objectForKey:@"name_fr_fr"]);
        cat.name_vi_vn = IGNORE_NSNULL([catDict objectForKey:@"name_vi_vn"]);
        cat.name_zh_tw = IGNORE_NSNULL([catDict objectForKey:@"name_zh_tw"]);
        
        cat.description_en_us = IGNORE_NSNULL([catDict objectForKey:@"description_en_us"]);
        cat.description_fr_fr = IGNORE_NSNULL([catDict objectForKey:@"description_fr_fr"]);
        cat.description_vi_vn = IGNORE_NSNULL([catDict objectForKey:@"description_vi_vn"]);
        cat.description_zh_tw = IGNORE_NSNULL([catDict objectForKey:@"description_zh_tw"]);   
        // get image
        if (![[catDict objectForKey:@"imageurl"] isEqualToString:@""]) {
            NSURL *url = [NSURL URLWithString:[catDict objectForKey:@"imageurl"]];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                // Use when fetching binary data
                NSData *responseData = [request responseData];
                UIImage *image = [UIImage imageWithData:(NSData *)responseData];
                cat.spotcategory_photo = image;
            }];
            [request setFailedBlock:^{
                NSError *error = [request error];
                DLog(@"error from image fetch: %@", error);
            }];
            [request startAsynchronous];
        }
        [SpotCategory getSpotsForCategoryId:cat.spotcategory_id withDelegate:self finishSelector:@selector(didGetSpots:) failureSelector:@selector(requestFailed:)];
    }
}



+ (void) didGetSpots:(ASIHTTPRequest *) request {
    if ([request responseStatusCode] != 200) {
        DLog(@"failed request");
        return;
    } else {
        [self syncSpotsFromResponse:[request responseString]];
    }
}

+ (void) requestFailed:(ASIHTTPRequest *)request {
    DLog(@"request failed: response code: %@", [request responseString] );
}



-(NSString *) getLocalizedName {
    if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"vi"]) {
		if (self.name_vi_vn != nil) {
			return self.name_vi_vn;
		}
	} else if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"fr"]) {
		if (self.name_fr_fr != nil) {
			return self.name_fr_fr;
		}
	} else if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"zh"]) {
		if (self.name_zh_tw != nil) {
			return self.name_zh_tw;
		}
        
	} 
	
	// default is english
	return self.name_en_us;
    
}
@end
