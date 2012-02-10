//
//  User+Extras.m
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/7/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "User+Extras.h"
#import "ApplicationDataService.h"
#import "NSManagedObjectContext+Helpers.h"
@implementation User (Extras)



-(void) updateWithDict:(NSDictionary  *) dict {
    /*
    if ([dict valueForKey:@"last_4_digits"] != [NSNull null]) {
        self.last_4_digits = [NSString stringWithFormat:@"%i", [dict valueForKey:@"last_4_digits"]];
    }
    self.email = [dict valueForKey:@"email"];
    self.name = [dict valueForKey:@"name"];
     */
    [[NSManagedObjectContext defaultManagedObjectContext] save:nil];  
}

@end
