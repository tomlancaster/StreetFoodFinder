//
//  SSViewController.h
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/11/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface SSViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
    IBOutlet UITableView *myTableView;
    NSArray *telcoImages;
}

@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSArray *telcoImages;
-(void) initHUD;

-(void) populateTelcoFromResponse:(NSString *) response ;

-(void) doPopulateWithResponse:(NSString *) response;

@end
