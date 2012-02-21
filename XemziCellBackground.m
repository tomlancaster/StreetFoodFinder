//
//  XemziCellBackground.m
//  XCC
//
//  Created by Tom Lancaster on 10/19/11.
//  Copyright (c) 2011 Sunshine Open Solutions. All rights reserved.
//

#import "XemziCellBackground.h"
#import "Common.h"

@implementation XemziCellBackground

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topColor = [UIColor colorWithRed:92.0/255.0 green:111.0/255.0 blue:116.0/255.0 alpha:1.0];
        self.bottomColor = [UIColor colorWithRed:57.0/255.0 green:70.0/255.0 blue:74.0/255.0 alpha:1.0];
    }
    return self;
}



@end