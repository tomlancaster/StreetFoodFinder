//
//  NSManagedObjectContext+SimpleFetches.m
//  SKW
//
//  Created by Tom Lancaster on 11/1/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+SimpleFetches.h"


@implementation NSManagedObjectContext (SimpleFetches)

- (NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription error:(NSError **)error;
{
	return [self fetchAllOfEntity:entityDescription predicate:nil error:error];
}

- (NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription predicate:(NSPredicate *)predicate error:(NSError **)error
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	[request setPredicate:predicate];
	//[request setReturnsObjectsAsFaults:NO];
	NSArray *results = [self executeFetchRequest:request error:error];
    [request release];
	
	return results;
}

- (NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription predicate:(NSPredicate *)predicate sortKey:(NSString *) sortKey error:(NSError **)error 
{
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	[request setPredicate:predicate];
	if (sortKey != nil) {
		NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:YES]; 
		NSArray * sortDescriptors = [NSArray arrayWithObject: sort]; 
		[request setSortDescriptors:sortDescriptors];
		[sort release];
		
	}
	//[request setReturnsObjectsAsFaults:NO];
	NSArray *results = [self executeFetchRequest:request error:error];
    [request release];
	
	return results;
}

-(NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription predicate:(NSPredicate *)predicate sortKey:(NSString *) sortKey ascending:(BOOL) asc error:(NSError **)error {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:entityDescription];
	[request setPredicate:predicate];
	if (sortKey != nil) {
		NSSortDescriptor * sort = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:asc]; 
		NSArray * sortDescriptors = [NSArray arrayWithObject: sort]; 
		[request setSortDescriptors:sortDescriptors];
		[sort release];
		
	}
	//[request setReturnsObjectsAsFaults:NO];
	NSArray *results = [self executeFetchRequest:request error:error];
    [request release];
	
	return results;
}


@end