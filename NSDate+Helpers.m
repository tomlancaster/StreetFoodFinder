//
//  NSDate+Helpers.m
//  SKW
//
//  Created by Tom Lancaster on 11/3/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "NSDate+Helpers.h"
#import "ISO8601DateFormatter.h"

@implementation NSDate (Helpers)

+(NSDate*) dateFromISO8601String:(NSString*) str { 
	if (str == nil) {
		DLog(@"date was a nil string");
		return nil;
	}
	ISO8601DateFormatter *formatter = [[ISO8601DateFormatter alloc] init];
	NSDate *theDate = [formatter dateFromString:str];
	[formatter release], formatter = nil;
	return theDate;
	/*
	if (str == nil) {
		DLog(@"date was a nil string");
		return nil;
	}
	static NSDateFormatter* sISO8601 = nil; 
	if (!sISO8601) { 
		sISO8601 = [[NSDateFormatter alloc] init]; 
		[sISO8601 setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];

		[sISO8601 setTimeStyle:NSDateFormatterFullStyle]; 
		[sISO8601 setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSSZZZ:ZZ"]; 
	} 
	if ([str hasSuffix:@"Z"]) { 
		str = [[str substringToIndex:(str.length-1)] 
			   stringByAppendingString:@"GMT"]; 
	} 
	DLog(@"str: %@", str);
	NSDate *theDate = [sISO8601 dateFromString:str];
	DLog(@"date: %@", theDate);
	return theDate; 
	 */
}

-(NSString *) dateToISO8601String {
	static NSDateFormatter* sISO8601 = nil; 
	if (!sISO8601) { 
		sISO8601 = [[NSDateFormatter alloc] init]; 
		[sISO8601 setTimeStyle:NSDateFormatterFullStyle]; 
		[sISO8601 setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSSSZZZ"]; 
	} 
	return [sISO8601 stringFromDate:self];
}




@end
