//
//  SSViewController.h
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/11/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface SSViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, NSFetchedResultsControllerDelegate> {
    MBProgressHUD *HUD;
    IBOutlet UITableView *myTableView;
    NSFetchedResultsController *fetchedResultsController;
    NSArray *sortDescriptors; // for any sorting factors
}

@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSArray *sortDescriptors;

- (void)findResults;

-(void) initHUD;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
