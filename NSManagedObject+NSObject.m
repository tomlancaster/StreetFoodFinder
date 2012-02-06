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



@end



