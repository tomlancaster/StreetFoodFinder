//
//  City.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Region, Spot;

@interface City : NSManagedObject

@property (nonatomic, retain) NSString * name_fr_fr;
@property (nonatomic, retain) NSString * name_en_us;
@property (nonatomic, retain) NSString * name_vi_vn;
@property (nonatomic, retain) NSString * name_zh_tw;
@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) Region *region;
@property (nonatomic, retain) NSSet *spots;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addSpotsObject:(Spot *)value;
- (void)removeSpotsObject:(Spot *)value;
- (void)addSpots:(NSSet *)values;
- (void)removeSpots:(NSSet *)values;
@end
