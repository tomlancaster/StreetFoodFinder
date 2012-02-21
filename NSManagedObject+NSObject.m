//
//  NSManagedObject+NSObject.m
//  SKW
//
//  Created by Tom Lancaster on 11/11/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "NSManagedObject+NSObject.h"


@implementation NSManagedObject (NSObject)

- (NSDictionary *)propertiesDictionary
{
	NSMutableDictionary *properties = [[[NSMutableDictionary alloc] init] autorelease];
	
	for (id property in [[self entity] properties])
	{
		if ([property isKindOfClass:[NSAttributeDescription class]])
		{
			NSAttributeDescription *attributeDescription = (NSAttributeDescription *)property;
			NSString *name = [attributeDescription name];
			[properties setValue:[self valueForKey:name] forKey:name];
		}
		
		if ([property isKindOfClass:[NSRelationshipDescription class]])
		{
			NSRelationshipDescription *relationshipDescription = (NSRelationshipDescription *)property;
			NSString *name = [relationshipDescription name];
			
			if ([relationshipDescription isToMany])
			{
				NSMutableArray *arr = [properties valueForKey:name];
				if (!arr)
				{
					arr = [[[NSMutableArray alloc] init] autorelease];
					[properties setValue:arr forKey:name];
				}
				
				for (NSManagedObject *o in [self mutableSetValueForKey:name])
					[arr addObject:[o propertiesDictionary]];
			}
			else
			{
				NSManagedObject *o = [self valueForKey:name];
				[properties setValue:[o propertiesDictionary] forKey:name];
			}
		}
	}
	
	return properties;
}  


- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSDictionary *attributes = [[self entity] attributesByName];
    for (NSString *attribute in attributes) {
        id value = [keyedValues objectForKey:attribute];
        if (value == nil) {
            continue;
        }
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value integerValue]];
        } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
            value = [dateFormatter dateFromString:value];
        } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [NSDate dateWithTimeIntervalSince1970:[value integerValue]];
        }
        [self setValue:value forKey:attribute];
    }
}



@end



