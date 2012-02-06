//
//  Spot.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Spot : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSNumber * spotcategory_id;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) NSManagedObject *city;
@property (nonatomic, retain) NSSet *spot_photos;
@property (nonatomic, retain) NSManagedObject *spot_category;
@end

@interface Spot (CoreDataGeneratedAccessors)

- (void)addSpot_photosObject:(NSManagedObject *)value;
- (void)removeSpot_photosObject:(NSManagedObject *)value;
- (void)addSpot_photos:(NSSet *)values;
- (void)removeSpot_photos:(NSSet *)values;
@end
