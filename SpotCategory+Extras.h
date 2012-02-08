//
//  SpotCategory+Extras.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "SpotCategory.h"
#import "SSASIRequest.h"

@interface SpotCategory (Extras)

+(void) getCategoriesWithDelegate:(id) theDelegate 
                   finishSelector:(SEL) success 
                  failureSelector:(SEL) failure;


@end
