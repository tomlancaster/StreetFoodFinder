//
//  SpotPhoto.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/14/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spot;

@interface SpotPhoto : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) id photo_small;
@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) id photo_large;
@property (nonatomic, retain) Spot *spot;

@end
