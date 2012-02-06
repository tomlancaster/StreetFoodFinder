//
//  SpotCategoryPhoto.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SpotCategoryPhoto : NSManagedObject

@property (nonatomic, retain) NSNumber * spotcategory_id;
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) NSSet *spotcategory;
@end

@interface SpotCategoryPhoto (CoreDataGeneratedAccessors)

- (void)addSpotcategoryObject:(NSManagedObject *)value;
- (void)removeSpotcategoryObject:(NSManagedObject *)value;
- (void)addSpotcategory:(NSSet *)values;
- (void)removeSpotcategory:(NSSet *)values;
@end
