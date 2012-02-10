//
//  URLService.m
//  SKW
//
//  Created by Tom on 10/19/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "URLService.h"


@implementation URLService



+(NSString *) getAPIServer {
	
	return API_SERVER;

}

+(NSString *)  getHTTPHeader {
    return @"pseudo user agent / 1.0";
}

@end
