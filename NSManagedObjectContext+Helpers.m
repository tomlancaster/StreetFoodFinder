//
//  NSManagedObject+Helpers.m
//  SKW
//
//  Created by Tom Lancaster on 11/1/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "NSManagedObjectContext+Helpers.h"
#import "AppDelegate.h"
#import <Foundation/Foundation.h>


@implementation NSManagedObjectContext (Helpers)

- (id)insertNewObjectForEntityWithName:(NSString *)entityName;
{
	return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
}

- (NSEntityDescription *)entityDescriptionForName:(NSString *)entityName;
{
	return [NSEntityDescription entityForName:entityName inManagedObjectContext:self];
}



+ (NSManagedObjectContext *)defaultManagedObjectContext {
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = [delegate defaultManagedObjectContext];
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
		[delegate setDefaultManagedObjectContext:managedObjectContext];
    }
    return managedObjectContext;
	
}

+ (NSManagedObjectContext *)bgManagedObjectContext {
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = [delegate bgManagedObjectContext];
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
		[delegate setBgManagedObjectContext:managedObjectContext];
    }
    return managedObjectContext;
	
}

+ (NSManagedObjectModel *)managedObjectModel {
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSManagedObjectModel *managedObjectModel = [delegate managedObjectModel];
	if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain]; 
	[delegate setManagedObjectModel:managedObjectModel];
    return managedObjectModel;
	
}

+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	NSPersistentStoreCoordinator *persistentStoreCoordinator = [delegate persistentStoreCoordinator];
	if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"database.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		DLog(@"Unresolved error %@, %@", error, [error userInfo]);
		UIAlertView *abortAlert = [[UIAlertView alloc] 
								   initWithTitle:NSLocalizedString(@"Fatal Error",@"")
								   message:NSLocalizedString(@"The application cannot start because of a serious error. Please press the home button to quit this application", @"")
								   delegate:nil
								   cancelButtonTitle:@"Darn"
								   otherButtonTitles:nil];	
		[abortAlert show];
		[abortAlert release];
    }    
	[delegate setPersistentStoreCoordinator:persistentStoreCoordinator];
    return persistentStoreCoordinator;
	
	
}
+ (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(void) resetPersistentStores {
	NSPersistentStoreCoordinator *psc = [self persistentStoreCoordinator];
	NSArray *stores = [psc persistentStores];
	
	for(NSPersistentStore *store in stores) {
		[psc removePersistentStore:store error:nil];
		[[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
	}
	
	[psc release], psc = nil;
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	delegate.persistentStoreCoordinator = nil;
	delegate.managedObjectModel = nil;
	delegate.defaultManagedObjectContext = nil;
	[delegate clearCache];
	[self persistentStoreCoordinator];
}	

@end