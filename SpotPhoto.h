//
//  SpotPhoto.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spot;

@interface SpotPhoto : NSManagedObject

@property (nonatomic, retain) NSNumber * spot_id;
@property (nonatomic, retain) id photo;
@property (nonatomic, retain) Spot *spot;

@end
