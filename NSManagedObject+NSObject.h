//
//  NSManagedObject+NSObject.h
//  SKW
//
//  Created by Tom Lancaster on 11/11/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSManagedObject (NSObject) 

- (NSDictionary *)propertiesDictionary;

- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter;

@end


