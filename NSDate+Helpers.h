//
//  NSDate+Helpers.h
//  SKW
//
//  Created by Tom Lancaster on 11/3/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (Helpers) 
	
	// thanks to Nathan Van Der Wilt ( http://www.cocoabuilder.com/archive/cocoa/201572-nsdate-from-xsd-datetime-iso-8601.html )
	
+(NSDate*) dateFromISO8601String:(NSString*) str;

-(NSString *) dateToISO8601String;



@end
