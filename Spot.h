//
//  Spot.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/16/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, SpotCategory, SpotPhoto;

@interface Spot : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) NSNumber * spotcategory_id;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * homepage;
@property (nonatomic, retain) NSNumber * star_rating;
@property (nonatomic, retain) NSNumber * num_reviews;
@property (nonatomic, retain) City *city;
@property (nonatomic, retain) SpotCategory *spot_category;
@property (nonatomic, retain) NSSet *spot_photos;


@end

@interface Spot (CoreDataGeneratedAccessors)

- (void)addSpot_photosObject:(SpotPhoto *)value;
- (void)removeSpot_photosObject:(SpotPhoto *)value;
- (void)addSpot_photos:(NSSet *)values;
- (void)removeSpot_photos:(NSSet *)values;
@end
