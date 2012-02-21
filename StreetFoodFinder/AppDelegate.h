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
    CategoryViewController *viewController;
    NSOperationQueue *queue;

}

@property (strong, nonatomic) UIWindow *window;
@property (assign, getter = isLoggedIn) BOOL loggedIn;
@property (strong, nonatomic) CategoryViewController *viewController;
@property (nonatomic, retain) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain) NSManagedObjectContext *defaultManagedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *bgManagedObjectContext;
@property (nonatomic, retain) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (assign) BOOL shouldNotLogOut;
@property (nonatomic, retain) User *globalUser;
@property (nonatomic, retain) NSOperationQueue *queue;


- (void)checkForNewVersion;

- (void) clearCache;


- (void)checkForNewVersion;

- (void) getCategories;

-(void) didGetCategories:(ASIHTTPRequest *) request;

-(void) populateDatabase;


@end
