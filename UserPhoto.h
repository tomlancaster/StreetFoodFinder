//
//  UserPhoto.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserPhoto : NSManagedObject

@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSNumber * user_photo_id;
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) User *user;

@end
