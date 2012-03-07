//
//  SpotCategory.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/7/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Spot;

@interface SpotCategory : NSManagedObject

@property (nonatomic, retain) NSString * description_en_us;
@property (nonatomic, retain) NSString * description_fr_fr;
@property (nonatomic, retain) NSString * description_vi_vn;
@property (nonatomic, retain) NSString * description_zh_tw;
@property (nonatomic, retain) NSString * name_en_us;
@property (nonatomic, retain) NSString * name_fr_fr;
@property (nonatomic, retain) NSString * name_vi_vn;
@property (nonatomic, retain) NSString * name_zh_tw;
@property (nonatomic, retain) NSNumber * parent_id;
@property (nonatomic, retain) NSNumber * spotcategory_id;
@property (nonatomic, retain) id spotcategory_photo;
@property (nonatomic, retain) NSSet *spots;
@end

@interface SpotCategory (CoreDataGeneratedAccessors)

- (void)addSpotsObject:(Spot *)value;
- (void)removeSpotsObject:(Spot *)value;
- (void)addSpots:(NSSet *)values;
- (void)removeSpots:(NSSet *)values;
@end
