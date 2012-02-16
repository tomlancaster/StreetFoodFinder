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

@implementation CategoryViewController

@synthesize landscapeView;
@synthesize portraitView;
@synthesize searchButton;
@synthesize nearbyButton;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc {
    SafeRelease(landscapeView);
    SafeRelease(portraitView);
    SafeRelease(searchButton);
    SafeRelease(nearbyButton);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:@"name_en_us" ascending:YES];
        self.sortDescriptors = [NSArray arrayWithObjects:nameSort, nil];
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

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
     SpotCategory *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
     cell.textLabel.text = [info getLocalizedName];
     //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", 
     //inf, info.state];
     
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SpotCategory *cat = [self.fetchedResultsController objectAtIndexPath:indexPath];
    SpotListViewController *controller = [[[SpotListViewController alloc] initWithNibName:@"SpotListViewController" bundle:nil] autorelease];
    controller.spotCategory = cat;
    [self.navigationController pushViewController:controller animated:YES];
    
}

#pragma -
#pragma AFOpenFlowViewDataSource
/*
- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index {
    
}

- (UIImage *)defaultImage {
    
}
*/


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Dishes", @"category list");
    self.navigationItem.rightBarButtonItem = self.searchButton;
    self.navigationItem.leftBarButtonItem = self.nearbyButton;
    [self findResults];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Event Handling

-(IBAction)openSearchView:(id)sender {
    
}

-(IBAction)openNearbyView:(id)sender {
    
}
@end
