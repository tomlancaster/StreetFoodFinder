//
//  APIService.m
//  SKW
//
//  Created by Tom on 10/18/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "APIService.h"

#import "NSData+Base64.h"
#import "NSDictionary+UrlEncoding.h"

#import "URLService.h"
#import "AppDelegate.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation APIService




+ (NSString *)stringWithHexFromData:(NSData *)data
{
    NSString *result = [[data description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result substringWithRange:NSMakeRange(1, [result length] - 2)];
    return result;
}
	
+(NSMutableDictionary *) getPhoneInformation {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrier = [netInfo subscriberCellularProvider];
	//if (NO) {
	if (carrier != nil) {
		[dict setValue:[carrier mobileNetworkCode] forKey:@"mnc"];
		[dict setValue:[carrier mobileCountryCode] forKey:@"mcc"];
	} else {
		[dict setValue:[NSNumber numberWithInt:2] forKey:@"mnc"];
		[dict setValue:[NSNumber numberWithInt:452] forKey:@"mcc"];
		[dict setValue:@"452022040170776" forKey:@"imsi"];
		[dict setValue:@"89840200020401707764" forKey:@"simid"];
		[dict setValue:@"01272170781" forKey:@"msisdn"];
		[dict setValue:@"357841031782176" forKey:@"imei"];
	}

	
	return dict;
}

@end
