//
//  NSManagedObjectContext+SimpleFetches.h
//  SKW
//
//  Created by Tom Lancaster on 11/1/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSManagedObjectContext (SimpleFetches)

- (NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription error:(NSError **)error;
- (NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription predicate:(NSPredicate *)predicate error:(NSError **)error;
- (NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription predicate:(NSPredicate *)predicate sortKey:(NSString *) sortKey error:(NSError **)error;
-(NSArray *)fetchAllOfEntity:(NSEntityDescription *)entityDescription predicate:(NSPredicate *)predicate sortKey:(NSString *) sortKey ascending:(BOOL) asc error:(NSError **)error;

@end

