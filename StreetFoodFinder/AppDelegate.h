//
//  AppDelegate.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@class ViewController;
@class User;
@class CategoryViewController;
@class TransitionController;
@class CoverFlowViewController;
@class CategoryViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, ASIHTTPRequestDelegate> {
    NSManagedObjectModel *managedObjectModel;
	NSManagedObjectContext *defaultManagedObjectContext;
    NSManagedObjectContext *bgManagedObjectContext;
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    UINavigationController *navigationController;
    NSString *userAgentString;
    BOOL loggedIn;
    User *globalUser;
    BOOL shouldNotLogOut;
    UIViewController *viewController;
    NSOperationQueue *queue;
    TransitionController *transitionController;
    CoverFlowViewController *coverFlowViewController;
    CategoryViewController *categoryViewController;

}

@property (strong, nonatomic) UIWindow *window;
@property (assign, getter = isLoggedIn) BOOL loggedIn;
@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *defaultManagedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *bgManagedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (assign) BOOL shouldNotLogOut;
@property (nonatomic, retain) User *globalUser;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) TransitionController *transitionController;
@property (nonatomic, retain) CoverFlowViewController *coverFlowViewController;
@property (nonatomic, retain) CategoryViewController *categoryViewController;


-(UIViewController *) getCurrentRootController;

- (void)checkForNewVersion;

- (void) clearCache;

- (NSString *)tileDbPath;

- (void)checkForNewVersion;

- (void) getCategories;

-(void) didGetCategories:(ASIHTTPRequest *) request;

-(void) populateDatabase;

- (void)createEditableCopyOfTileDatabaseIfNeeded;


@end
