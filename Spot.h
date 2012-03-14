//
//  Spot.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/14/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, Review, SpotCategory, SpotPhoto;

@interface Spot : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSString * homepage;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * num_reviews;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) NSNumber * spotcategory_id;
@property (nonatomic, retain) NSNumber * star_rating;
@property (nonatomic, retain) NSNumber * oh_morning;
@property (nonatomic, retain) NSNumber * oh_lunch;
@property (nonatomic, retain) NSNumber * oh_afternoon;
@property (nonatomic, retain) NSNumber * oh_evening;
@property (nonatomic, retain) NSNumber * oh_late;
@property (nonatomic, retain) City *city;
@property (nonatomic, retain) NSSet *reviews;
@property (nonatomic, retain) SpotCategory *spot_category;
@property (nonatomic, retain) NSSet *spot_photos;
@end

@interface Spot (CoreDataGeneratedAccessors)

- (void)addReviewsObject:(Review *)value;
- (void)removeReviewsObject:(Review *)value;
- (void)addReviews:(NSSet *)values;
- (void)removeReviews:(NSSet *)values;
- (void)addSpot_photosObject:(SpotPhoto *)value;
- (void)removeSpot_photosObject:(SpotPhoto *)value;
- (void)addSpot_photos:(NSSet *)values;
- (void)removeSpot_photos:(NSSet *)values;
@end
