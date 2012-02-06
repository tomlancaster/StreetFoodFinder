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
	
	NSString *server = [[NSUserDefaults standardUserDefaults] valueForKey:@"api_server"];
	if (server != nil) {
		return server;
	} else {
		return [NSString stringWithFormat:@"%@/api/v%d",API_SERVER, API_VERSION];
	}

}

@end
