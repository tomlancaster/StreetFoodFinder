//
//  NSManagedObject+Helpers.h
//  SKW
//
//  Created by Tom Lancaster on 11/1/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Helpers)

// hat-tip: Jeff LaMarche, http://is.gd/aP0AQ
// and 
- (id)insertNewObjectForEntityWithName:(NSString *)entityName;
- (NSEntityDescription *)entityDescriptionForName:(NSString *)entityName;

// thanks to Corey Floyd (http://stackoverflow.com/questions/1267520/where-to-place-the-core-data-stack-in-a-cocoa-cocoa-touch-application)
// ( this keeps the app delegate clean)
+ (NSManagedObjectContext *)defaultManagedObjectContext;
+ (NSManagedObjectModel *)managedObjectModel;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
+ (NSString *)applicationDocumentsDirectory;

+(void) resetPersistentStores;

@end

