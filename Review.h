//
//  Review.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/20/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spot, User;

@interface Review : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSNumber * featured;
@property (nonatomic, retain) NSString * lang;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * review_id;
@property (nonatomic, retain) Spot *spot;
@property (nonatomic, retain) User *user;

@end
