//
//  DeviceDetection.h
//  HanoiCityCompanion
//
//  Created by Tom on 2/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <sys/utsname.h>

enum {
    MODEL_IPHONE_SIMULATOR,
    MODEL_IPOD_TOUCH,
    MODEL_IPHONE,
    MODEL_IPHONE_3G
};


@interface DeviceDetection : NSObject {

}

+ (uint) detectDevice;
+ (NSString *) returnDeviceName:(BOOL)ignoreSimulator;

@end
