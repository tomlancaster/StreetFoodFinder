//
//  CategoryViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/10/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "CategoryViewController.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "SpotCategory.h"
#import "SpotCategory+Extras.h"
#import "SpotListViewController.h"
#import "ApplicationDataService.h"
#import "CategoryTableViewCell.h"
#import "CoverFlowViewController.h"
#import "CategoryDescriptionViewController.h"
#import "NormalCellBackground.h"


@implementation CategoryViewController

@synthesize nearbyButton;
@synthesize myNavBar;
@synthesize myNavItem;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc {

    SafeRelease(nearbyButton);
    SafeRelease(myNavBar);
    SafeRelease(myNavItem);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:@"name_en_us" ascending:YES];
        self.sortDescriptors = [NSArray arrayWithObjects:nameSort, nil];
        [nameSort release];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)findResults;
{
    if (fetchedResultsController == nil) {
        NSFetchRequest *resultsFetchRequest = [[NSFetchRequest alloc] init];
        [resultsFetchRequest setEntity:[[NSManagedObjectContext defaultManagedObjectContext] entityDescriptionForName:@"SpotCategory"]];
        
        [resultsFetchRequest setSortDescriptors:self.sortDescriptors];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:resultsFetchRequest managedObjectContext:[NSManagedObjectContext defaultManagedObjectContext] sectionNameKeyPath:nil cacheName:@"Categories"];
        fetchedResultsController.delegate = self;
        
        [resultsFetchRequest release];
    }
    
    [fetchedResultsController performFetch:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CategoryTableViewCell";
    CategoryTableViewCell *cell = (CategoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        // Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"CategoryTableViewCell" bundle:nil];
        // Grab a pointer to the custom cell.
        
        cell = (CategoryTableViewCell *)temporaryController.view;
        [temporaryController release];
    }    
    // Set up the cell...
   
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    cell.backgroundView = [[[NormalCellBackground alloc] init] autorelease];
    cell.selectedBackgroundView = [[[NormalCellBackground alloc] init] autorelease];
    
    
    CALayer *l = [cell.backgroundView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];  
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor darkGrayColor] CGColor]];
    
}



- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
     SpotCategory *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
     [(CategoryTableViewCell *)cell catLabel].text = [info getLocalizedName];
    [[(CategoryTableViewCell *)cell descriptionButton] addTarget:self action:@selector(descriptionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [[(CategoryTableViewCell *)cell spotsButton] addTarget:self action:@selector(spotsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
     
     
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SpotCategory *cat = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self openSpotListPageWithCat:cat];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [myTableView setBackgroundView:nil];
    [myTableView setBackgroundView:[[[UIView alloc] init] autorelease]];
    
    self.myNavItem.title = NSLocalizedString(@"Dishes", @"category list");
    self.myNavBar.tintColor = [UIColor greenColor];
    self.myNavItem.rightBarButtonItem = self.nearbyButton;
    [self findResults];
    [FlurryAnalytics logPageView];
}

-(void) viewWillAppear:(BOOL)animated {
    //[[self navigationController] setNavigationBarHidden:NO animated:NO];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        [appDelegate.transitionController transitionToViewController:appDelegate.coverFlowViewController withOptions:UIViewAnimationOptionTransitionCrossDissolve] ;
    }
    [self.myNavBar setHidden:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
   
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
         [appDelegate.transitionController transitionToViewController:appDelegate.coverFlowViewController withOptions:UIViewAnimationOptionTransitionCrossDissolve] ;
    }
}



#pragma mark -
#pragma mark Event Handling

-(IBAction)openNearbyView:(id)sender {
    SpotListViewController *controller = [[[SpotListViewController alloc] initWithNibName:@"SpotListViewController" bundle:nil] autorelease];
    controller.sortBy = 1;
    // get all spots
    ApplicationDataService *ads = [[[ApplicationDataService alloc] initWithIdName:@"spot_id" entityName:@"Spot"] autorelease];
    controller.spots = [ads getAllLocal];
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.transitionController transitionToViewController:navController withOptions:UIViewAnimationOptionTransitionCrossDissolve];
}


-(IBAction)descriptionButtonPressed:(id)sender {
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:(UITableViewCell *)[[sender superview]superview]];
    SpotCategory *cat = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self openDescriptionOfCategory:cat];
}
-(IBAction)spotsButtonPressed:(id)sender {
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:(UITableViewCell *)[[sender superview] superview]];
    SpotCategory *cat = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self openSpotListPageWithCat:cat];
}

-(void) openDescriptionOfCategory:(SpotCategory *) cat {
    CategoryDescriptionViewController *controller = [[[CategoryDescriptionViewController alloc] initWithNibName:@"CategoryDescriptionViewController" bundle:nil] autorelease];
    controller.cat = cat;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.transitionController transitionToViewController:controller withOptions:UIViewAnimationCurveEaseIn];
}

-(void) openSpotListPageWithCat:(SpotCategory *) cat {
    SpotListViewController *controller = [[[SpotListViewController alloc] initWithNibName:@"SpotListViewController" bundle:nil] autorelease];
    controller.spotCategory = cat;
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.transitionController transitionToViewController:navController withOptions:UIViewAnimationOptionTransitionCrossDissolve];
}
@end
