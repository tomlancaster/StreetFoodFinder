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

-(void) registerUserWithDelegate:(id) theDelegate 
                  finishSelector:(SEL) success 
                 failureSelector:(SEL) failure {
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:@"/users.json"] autorelease];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.name, @"name", self.email, @"email", self.password, @"password", self.password_confirmation, @"password_confirmation", nil] forKey:@"user"];

    [request doPostWithGetPostDict:[NSMutableDictionary dictionaryWithObjectsAndKeys:dict, @"post", nil] andDelegate:theDelegate finishSelector:success failureSelector:failure synchronous:YES];
    
}

-(void) loginUserWithDelegate:(UIViewController *) delegate 
                     password:(NSString *) password 
               finishSelector:(SEL) success 
              failureSelector:(SEL) failure {
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:@"/sessions.json"] autorelease];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:self.email, @"email", password, @"password", nil] forKey:@"user"];
    
    [request doPostWithGetPostDict:[NSMutableDictionary dictionaryWithObjectsAndKeys:dict, @"post", nil] andDelegate:delegate finishSelector:success failureSelector:failure synchronous:YES];
    
    
}


-(void) purchaseProduct:(Product *) theProduct 
           withDelegate:(id) theDelegate 
         finishSelector:(SEL) success 
        failureSelector:(SEL) failure {
    NSString *path = [NSString stringWithFormat:@"/products/purchase/%d.json", [theProduct.product_id intValue]];
    if (self.stripe_token != nil) {
        path = [path stringByAppendingFormat:@"?stripe_token=%@", self.stripe_token];
    }
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:path] autorelease];
    [request doGetWithDict:nil andDelegate:theDelegate finishSelector:success failureSelector:failure];
    
}

-(void) addStripeToken:(NSString *) theToken 
          withDelegate:(id) theDelegate 
        finishSelector:(SEL) success 
       failureSelector:(SEL) failure {
    NSString *path = [NSString stringWithFormat:@"/users/add_stripe_token.json?stripe_token=%@", theToken];
    
    
    SSASIRequest *request = [[[SSASIRequest alloc] initWithPath:path] autorelease];
    [request doPostWithGetPostDict:nil andDelegate:theDelegate finishSelector:success failureSelector:failure];
}

-(void) updateWithDict:(NSDictionary  *) dict {
    if ([dict valueForKey:@"last_4_digits"] != [NSNull null]) {
        self.last_4_digits = [NSString stringWithFormat:@"%i", [dict valueForKey:@"last_4_digits"]];
    }
    self.email = [dict valueForKey:@"email"];
    self.name = [dict valueForKey:@"name"];
    [[NSManagedObjectContext defaultManagedObjectContext] save:nil];  
}

@end
