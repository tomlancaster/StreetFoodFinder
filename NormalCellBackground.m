//
//  NormalCellBackground.m
//  XCC
//
//  Created by Tom Lancaster on 10/19/11.
//  Copyright (c) 2011 Sunshine Open Solutions. All rights reserved.
//

#import "NormalCellBackground.h"
#import "Common.h"

@implementation NormalCellBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topColor = [UIColor colorWithRed:55.0/255.0 green:62.0/255.0 blue:71.0/255.0 alpha:1.0];
        self.bottomColor = [UIColor colorWithRed:43.0/255.0 green:44.0/255.0 blue:47.0/255.0 alpha:1.0];
    }
    return self;
}

@end
