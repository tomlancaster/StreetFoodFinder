//
//  ApplicationDataService.m
//  SKW
//
//  Created by Tom on 10/18/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "ApplicationDataService.h"


#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "JSONKit.h"
#import <objc/runtime.h>

#import "NSDictionary+UrlEncoding.h"
#import "AppDelegate.h"

#import "SSASIRequest.h"




@implementation ApplicationDataService

@synthesize idName;
@synthesize entityName;
@synthesize eDescription;



-(void) dealloc {
    SafeRelease(idName);
    SafeRelease(entityName);
    SafeRelease(eDescription);
	[super dealloc];
	
}

-(id) initWithIdName:(NSString *)name entityName:(NSString *)eName {
    if ((self = [super init])) {
        self.idName = name;
        self.entityName = eName;
        self.eDescription = [[NSManagedObjectContext defaultManagedObjectContext] entityDescriptionForName:self.entityName];
    }
    return self;
}



+(NSString *) getCacheName {
	NSString *cacheName = nil;
	u_int count;

	objc_property_t* properties = class_copyPropertyList(self, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
	NSArray *possibleCacheNames = [NSArray arrayWithObjects:@"updated_at", nil];
	for (NSString *cn in possibleCacheNames) {
		if ([propertyArray containsObject:cn]) {
			cacheName = cn;
			break;
		}
	}
	if (cacheName == nil) {
		NSLog(@"NIL cachename for class %@", [self class]);
	}
	return cacheName;
	
}

-(NSDate *) getLastUpdateLocalForEntity:(NSString *) entity {
	NSDate *lastCacheDate = nil;
	NSString *cacheName = [NSClassFromString(entity) getCacheName];
	if (cacheName == nil) {
		return [NSDate dateWithTimeIntervalSince1970:0];
	}
	
	
	NSArray *localEnts = [[NSManagedObjectContext defaultManagedObjectContext] fetchAllOfEntity:self.eDescription predicate:nil sortKey:cacheName ascending:YES error:nil];
	if (localEnts != nil && [localEnts count] > 0) {
		lastCacheDate = [[localEnts objectAtIndex:0] valueForKey:cacheName];
	} 
	if (lastCacheDate == nil) {
		lastCacheDate = [NSDate dateWithTimeIntervalSince1970:0];
	}
	return lastCacheDate;
	
}

-(NSDate *) getLastUpdateLocalForEntities:(NSMutableArray *) entityList {
	NSDate *lastCacheDate = [NSDate dateWithTimeIntervalSince1970:0];
	NSString *cacheName = nil;
	if (cacheName == nil) {
		return lastCacheDate;
	}
	
	int numRequired = [entityList count];

	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN %@", self.idName, entityList];
	NSArray *localEnts = [[NSManagedObjectContext defaultManagedObjectContext] fetchAllOfEntity:self.eDescription predicate:predicate sortKey:cacheName ascending:YES error:nil];
	if (localEnts != nil && [localEnts count] > 0) {
		lastCacheDate = [[localEnts objectAtIndex:0] valueForKey:cacheName];
	} 
	
	
	if (([localEnts count] < numRequired) || localEnts == nil || ([localEnts count] == 0)) {
		// we don't have all of these entities, return distant past date
		return lastCacheDate;
	} else {
		return [[localEnts objectAtIndex:0] valueForKey:cacheName];
	}	
}

-(void) setLastUpdateLocal:(NSDate *) date {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:date forKey:[@"cache_time_" stringByAppendingString:self.entityName]];
	[defaults synchronize];
}

	

-(NSArray *) getLocalByIds:(NSMutableArray *) objectIds {
	NSString *predStub = [NSString stringWithFormat:@"%@ IN %%@", self.idName];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predStub, objectIds];
	NSArray *localEnts = [[NSManagedObjectContext defaultManagedObjectContext] fetchAllOfEntity:self.eDescription predicate:predicate error:nil];
	return localEnts;
}

-(id) getLocalById:(id) objectId {
	if (objectId == nil) {
		return nil;
	}
	
	NSString *predStub = [NSString stringWithFormat:@"%@ == %%@", self.idName];
	//DLog(@"predStub: %@", predStub);
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predStub, objectId];
	//DLog(@"predicate: %@", predicate);
	NSError *error = nil;
	NSArray *allObjs = nil;
	allObjs = [[NSManagedObjectContext defaultManagedObjectContext] fetchAllOfEntity:self.eDescription predicate:predicate error:&error];
	if (error) {
		DLog(@"error from fetch: %@", error);
	}
	if ([allObjs count] > 0) {
		//DLog(@"we have %d existing %@.", [allObjs count], [self getEntityName]);
	//	DLog(@"all objs: %@", allObjs);
		return [allObjs objectAtIndex:0];
	} else {
		//DLog(@"no matching local %@ for ids %@", [self getEntityName], objectId);
		
		return nil;
	}
}

-(NSArray *) getAllLocal {
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:self.eDescription];
	
	NSError *error;
	
	NSArray *array = [[NSManagedObjectContext defaultManagedObjectContext] executeFetchRequest:request error:&error];
	return array;
}

// returns an array of objects that were either matched or created by the incoming dictionaries

-(NSMutableArray *) mergeWithLocal:(NSMutableArray *) resourceDicts {
	NSMutableArray *returnObjects = [NSMutableArray array];
	//DLog(@"in mergeWithLocal. Entity name is %@", [self getEntityName]);
	if (resourceDicts == nil || [resourceDicts count] == 0) {
		return returnObjects;
	}
	for (NSDictionary *dict in resourceDicts) {
		id localEvent = nil;
		localEvent = [self getLocalById:[dict valueForKey:self.idName]];
		if (localEvent == nil) {
			//DLog(@"local Object is nil");
			localEvent = [[NSManagedObjectContext defaultManagedObjectContext] insertNewObjectForEntityWithName:self.entityName];
			
		}
		//DLog(@"local object: %@", localEvent);
		//DLog(@"dict to merge: %@", dict);
		[localEvent populateWithDict:dict];
		//DLog(@"local object post-merge: %@", localEvent);
		[returnObjects addObject:localEvent];
		localEvent = nil;
	}
	NSError *error = nil;
	if (![[NSManagedObjectContext defaultManagedObjectContext] save:&error]) {
		DLog(@"unable to save local");
		DLog(@"error: %@", [error localizedDescription]);
		
		if (error != nil) {
			// [error retain];
			DLog(@"Failed to save merged %@: %@", self.entityName, [error localizedDescription]);
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
		
	} else {
		//DLog(@"successfully merged %@", [self getEntityName]);
		//[ApplicationDataService setLastUpdateLocal:[NSDate date] forEntity:[self getEntityName]];
		//return returnObjects;
	}
	return returnObjects;
	
}



-(void) populateWithDict:(NSDictionary *)dict {
	// implement in child
}
	
-(void) handleNon200Response:(ASIHTTPRequest *) request {
	DLog(@"non-200 response for url: %@, post: %@ in getEntityDidFinish: %@", [request url], [[[NSString alloc] initWithData:[request postBody] encoding:NSUTF8StringEncoding] autorelease] , [request responseString]);

}

-(NSMutableDictionary *) toDictionary {
	return nil;
}

@end
