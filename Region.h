//
//  Region.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Region : NSManagedObject

@property (nonatomic, retain) NSNumber * region_id;
@property (nonatomic, retain) NSString * name_en_us;
@property (nonatomic, retain) NSString * name_fr_fr;
@property (nonatomic, retain) NSString * name_vi_vn;
@property (nonatomic, retain) NSString * name_zh_tw;
@property (nonatomic, retain) UNKNOWN_TYPE url_form;
@property (nonatomic, retain) NSSet *cities;
@property (nonatomic, retain) NSManagedObject *country;
@end

@interface Region (CoreDataGeneratedAccessors)

- (void)addCitiesObject:(NSManagedObject *)value;
- (void)removeCitiesObject:(NSManagedObject *)value;
- (void)addCities:(NSSet *)values;
- (void)removeCities:(NSSet *)values;
@end
