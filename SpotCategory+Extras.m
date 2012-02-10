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

@implementation SpotCategory (Extras)

+(void) getCategoriesWithDelegate:(id) theDelegate 
                   finishSelector:(SEL) success 
                  failureSelector:(SEL) failure {
    NSString *path = [NSString stringWithFormat:@"/venuecategory/get_json?venuecategory_id=%@", STREETFOODCAT];
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:path] autorelease];
    [request doGetWithDict:nil andDelegate:theDelegate finishSelector:success failureSelector:failure];
    
    
}

+(void) syncFromResponse:(NSString *) response {
        
    ApplicationDataService *ADS = [[[ApplicationDataService alloc] initWithIdName:@"spotcategory_id" entityName:@"SpotCategory"] autorelease];
    
    
    NSDictionary *responseArray = [response objectFromJSONString];
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
    }
    
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
