//
//  Country.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Region;

@interface Country : NSManagedObject

@property (nonatomic, retain) NSNumber * country_id;
@property (nonatomic, retain) UNKNOWN_TYPE attribute;
@property (nonatomic, retain) NSString * name_en_us;
@property (nonatomic, retain) NSString * name_fr_fr;
@property (nonatomic, retain) NSString * name_vi_vn;
@property (nonatomic, retain) NSString * name_zh_tw;
@property (nonatomic, retain) NSSet *regions;
@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addRegionsObject:(Region *)value;
- (void)removeRegionsObject:(Region *)value;
- (void)addRegions:(NSSet *)values;
- (void)removeRegions:(NSSet *)values;
@end
