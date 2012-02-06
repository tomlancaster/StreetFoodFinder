//
//  ApplicationDataService.h
//  SKW
//
//  Created by Tom on 10/18/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "APIService.h"
@class APIService;
@class SSASIRequest;
@class ASIHTTPRequest;




@interface ApplicationDataService : NSObject {
		
	NSString *idName;
    NSString *entityName;
    NSEntityDescription *eDescription;

	
}

@property (nonatomic, retain) NSString *idName;
@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSEntityDescription *eDescription;


-(id) initWithIdName:(NSString *) idName entityName:(NSString *) eName;






-(void) populateWithDict:(NSDictionary *) dict;

-(NSMutableDictionary *) toDictionary;



// these will be implemented in most subclasses

-(NSArray *) getLocalByIds:(NSMutableArray *) objectIds;

-(id) getLocalById:(id) objectId;

-(NSArray *) getAllLocal;

-(NSMutableArray *) mergeWithLocal:(NSMutableArray *) dictsArray;



-(NSDate *) getLastUpdateLocalForEntity:(NSString *) entity;

-(NSDate *) getLastUpdateLocalForEntities:(NSMutableArray *) entityList;

-(void) setLastUpdateLocal:(NSDate *) date ;

-(void) handleNon200Response:(ASIHTTPRequest *) request;

@end
