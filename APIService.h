//
//  APIService.h
//  SKW
//
//  Created by Tom on 10/18/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "URLService.h"





@interface APIService : NSObject {

	

}

+ (NSString *)stringWithHexFromData:(NSData *)data;
	
+(NSMutableDictionary *) getPhoneInformation;



@end
