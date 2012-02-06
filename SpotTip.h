//
//  SpotTip.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface SpotTip : NSManagedObject

@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSDate * created_on;
@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) User *user;

@end
