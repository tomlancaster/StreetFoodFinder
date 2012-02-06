//
//  SSASIRequest.h
//  SKW
//
//  Created by Tom Lancaster on 2/8/11.
//  Copyright 2011 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface SSASIRequest : ASIHTTPRequest {
	NSString *path;
}

-(SSASIRequest *) initWithPath:(NSString *)newPath;

-(void) doGetWithDict:(NSDictionary *)dict 
          andDelegate:(id) theDelegate 
       finishSelector:(SEL) success 
      failureSelector:(SEL) failure;

-(void) createGetWithDict:(NSDictionary *)dict 
               andDelegate:(id) theDelegate 
            finishSelector:(SEL) success 
           failureSelector:(SEL) failure;

-(void) doPostWithGetPostDict:(NSDictionary *)getPostDict 
                  andDelegate:(id) theDelegate 
               finishSelector:(SEL) success 
              failureSelector:(SEL) failure;
-(void) doPostWithGetPostDict:(NSDictionary *)getPostDict 
                  andDelegate:(id) theDelegate 
               finishSelector:(SEL) success 
              failureSelector:(SEL) failure
synchronous:(BOOL) synchronous;

-(void) createPostWithGetPostDict:(NSDictionary *)getPostDict 
                      andDelegate:(id) theDelegate 
                   finishSelector:(SEL) success 
                  failureSelector:(SEL) failure;

@end
