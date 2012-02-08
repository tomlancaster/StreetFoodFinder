//
//  User.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Review;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSSet *reviews;
@property (nonatomic, retain) NSSet *spottips;
@property (nonatomic, retain) NSSet *user_photos;
@property (nonatomic, retain) NSNumber *user_id;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addReviewsObject:(Review *)value;
- (void)removeReviewsObject:(Review *)value;
- (void)addReviews:(NSSet *)values;
- (void)removeReviews:(NSSet *)values;
- (void)addSpottipsObject:(NSManagedObject *)value;
- (void)removeSpottipsObject:(NSManagedObject *)value;
- (void)addSpottips:(NSSet *)values;
- (void)removeSpottips:(NSSet *)values;
- (void)addUser_photosObject:(NSManagedObject *)value;
- (void)removeUser_photosObject:(NSManagedObject *)value;
- (void)addUser_photos:(NSSet *)values;
- (void)removeUser_photos:(NSSet *)values;
@end
