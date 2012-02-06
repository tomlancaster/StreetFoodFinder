//
//  NSDictionary+UrlEncoding.m
//  SKW
//
//  Created by Tom on 10/21/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "NSDictionary+UrlEncoding.h"

// helper function: get the string form of any object
static NSString *toString(id object) {
	return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
	NSString *string = toString(object);
	NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)string,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8 );
	return encodedString;
	//return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (UrlEncoding)

-(NSString*) urlEncodedString {
	NSMutableArray *parts = [NSMutableArray array];
	for (id key in self) {
		id value = [self objectForKey: key];
		NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
		[parts addObject: part];
	}
	return [parts componentsJoinedByString: @"&"];
}

@end

