//
//  XZMarker.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/30/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "RMMarker.h"
@class Spot;
@interface XZMarker : RMMarker {
    Spot *spot;
}


@property (nonatomic, retain) Spot *spot;



@end
