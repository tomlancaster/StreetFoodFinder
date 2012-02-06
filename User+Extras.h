//
//  User+Extras.h
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/7/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "User.h"
#import "SSASIRequest.h"
#import "Product.h"
@interface User (Extras)



-(void) registerUserWithDelegate:(id) theDelegate 
                  finishSelector:(SEL) success 
                 failureSelector:(SEL) failure;

-(void) loginUserWithDelegate:(UIViewController *) delegate 
                     password:(NSString *) password 
               finishSelector:(SEL) success 
              failureSelector:(SEL) failure;


-(void) purchaseProduct:(Product *) theProduct 
           withDelegate:(id) theDelegate 
                  finishSelector:(SEL) success 
                 failureSelector:(SEL) failure;

-(void) addStripeToken:(NSString *) theToken 
           withDelegate:(id) theDelegate 
         finishSelector:(SEL) success 
        failureSelector:(SEL) failure;

-(void) updateWithDict:(NSDictionary  *) dict;

@end
