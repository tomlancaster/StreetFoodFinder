//
//  SSASIRequest.m
//  SKW
//
//  Created by Tom Lancaster on 2/8/11.
//  Copyright 2011 Sunshine Open Solutions. All rights reserved.
//

#import "SSASIRequest.h"
#import "APIService.h"
#import "URLService.h"
#import "NSDictionary+UrlEncoding.h"
#import "AppDelegate.h"
#import "JSONKit.h"

@implementation SSASIRequest


-(SSASIRequest *) initWithPath:(NSString *)newPath {
	
	
	NSURL *newURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [URLService getAPIServer], newPath]];
	self = [super initWithURL:newURL];
	if (self) {
		path = newPath;
		// set custom header
		
		[self addRequestHeader:@"User-Agent" value:[URLService getHTTPHeader]];
		//TODO: any other defaults
	}
	
	return self;
}

-(void) doGetWithDict:(NSDictionary *)dict 
          andDelegate:(id) theDelegate 
       finishSelector:(SEL) success 
      failureSelector:(SEL) failure {
    [self createGetWithDict:dict andDelegate:theDelegate finishSelector:success failureSelector:failure];
	[self startAsynchronous];
}

-(void) createGetWithDict:(NSDictionary *)dict 
               andDelegate:(id) theDelegate 
            finishSelector:(SEL) success 
           failureSelector:(SEL) failure {
    // get default params
	NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
	[requestParams addEntriesFromDictionary:dict];
	NSString *queryString = [requestParams urlEncodedString];
    NSString *urlString;
	if (queryString != nil) {
        urlString = [NSString stringWithFormat:@"%@%@?%@", [URLService getAPIServer], path, queryString];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@", [URLService getAPIServer], path];
    }
	[self setURL:[NSURL URLWithString:urlString]];
	[self setDidFinishSelector:success];
	[self setDidFailSelector:failure];
	[self setDelegate:theDelegate];
    self.useCookiePersistence = YES;


}
-(void) doPostWithGetPostDict:(NSDictionary *)getPostDict 
                  andDelegate:(id) theDelegate 
               finishSelector:(SEL) success 
              failureSelector:(SEL) failure
                  synchronous:(BOOL) synchronous {
    synchronous = NO;
    [self createPostWithGetPostDict:getPostDict andDelegate:theDelegate finishSelector:success failureSelector:failure];
    if (synchronous) {
        [self startSynchronous];
    } else {
        [self startAsynchronous];
    }
    
	
    
}
-(void) doPostWithGetPostDict:(NSDictionary *)getPostDict 
                  andDelegate:(id) theDelegate 
               finishSelector:(SEL) success 
              failureSelector:(SEL) failure {
    [self doPostWithGetPostDict:getPostDict andDelegate:theDelegate finishSelector:success failureSelector:failure synchronous:NO];
}

-(void) createPostWithGetPostDict:(NSDictionary *)getPostDict 
                      andDelegate:(id) theDelegate 
                   finishSelector:(SEL) success 
                  failureSelector:(SEL) failure {
    // get default params
	NSMutableDictionary *requestParams = [NSMutableDictionary dictionary];
	[requestParams addEntriesFromDictionary:[getPostDict valueForKey:@"get"]];
	//DLog(@"request params: %@", requestParams);
	NSString *queryString = [requestParams urlEncodedString];
	NSString *postString = [[getPostDict valueForKey:@"post"] JSONString];
	[self appendPostData:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [self setRequestMethod:@"POST"];
	self.shouldCompressRequestBody = NO;
    [self addRequestHeader:@"Content-Type" value:@"application/json; charset=UTF-8"];
	NSString *urlString = [NSString stringWithFormat:@"%@%@?%@", [URLService getAPIServer], path, queryString];
	[self setURL:[NSURL URLWithString:urlString]];
	[self setDidFinishSelector:success];
	[self setDidFailSelector:failure];
	[self setDelegate:theDelegate];
}



	


@end
