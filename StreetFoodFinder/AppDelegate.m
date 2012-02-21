//
//  AppDelegate.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "UIDevice-Hardware.h"
#import "ASIHTTPRequest.h"
#import "NSManagedObject+NSObject.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "SpotCategory+Extras.h"
#import "SpotCategory.h"
#import "ASIHTTPRequest.h"
#import "CategoryViewController.h"
#import "SSCLController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize managedObjectModel;
@synthesize defaultManagedObjectContext;
@synthesize persistentStoreCoordinator;
@synthesize navigationController;
@synthesize loggedIn;
@synthesize shouldNotLogOut;
@synthesize globalUser;
@synthesize queue;
@synthesize bgManagedObjectContext;


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [navigationController release];
	[managedObjectModel release];
	[defaultManagedObjectContext release];
    [bgManagedObjectContext release];
	[persistentStoreCoordinator release];
    [queue release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    // Show the app version in the Settings app
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	[[NSUserDefaults standardUserDefaults] setObject:version forKey:@"version_preference"];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:self.viewController] autorelease];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    self.window.rootViewController = self.navigationController;
    if (![self queue]) {
		[self setQueue:[[NSOperationQueue alloc] init]];
        [self.queue setMaxConcurrentOperationCount:1];
        [self.queue addObserver:self forKeyPath:@"operations" options:0 context:NULL];
	}
   
    [self populateDatabase];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object 
                         change:(NSDictionary *)change context:(void *)context
{
    //DLog(@"KVP Change: %@", change);
    if (object == self.queue && [keyPath isEqual:@"operations"]) {
        if ([self.queue.operations count] == 0) {
            // Do something here when your queue has completed
            NSLog(@"queue has completed");			
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object 
                               change:change context:context];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

// this is the first step in a chain of fetches: 
// cats -> spots per cat -> reviews per spot
-(void) populateDatabase {
    [self getCategories];
}



- (void) getCategories {
    // fetch all local cats
    [SpotCategory getCategoriesWithDelegate:self finishSelector:@selector(didGetCategories:) failureSelector:@selector(requestFailed:)];
     
}

-(void) didGetCategories:(ASIHTTPRequest *) request {
    if ([request responseStatusCode] != 200) {
        DLog(@"failed request");
        return;
    } else {
        DLog(@"got categories: %@", [request responseString]);
        [SpotCategory syncFromResponse:[request responseString]];
    }
}

-(void) requestFailed:(ASIHTTPRequest *)request {
    DLog(@"Foo");
}



@end
