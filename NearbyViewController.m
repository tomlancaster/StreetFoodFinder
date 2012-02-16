//
//  NearbyViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/16/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "NearbyViewController.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "Spot.h"
#import "Spot+Extras.h"

@implementation NearbyViewController

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

- (void)findResults;
{
    if (fetchedResultsController == nil) {
        NSFetchRequest *resultsFetchRequest = [[NSFetchRequest alloc] init];
        [resultsFetchRequest setEntity:[[NSManagedObjectContext defaultManagedObjectContext] entityDescriptionForName:@"Spot"]];
        
        [resultsFetchRequest setSortDescriptors:self.sortDescriptors];
        
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:resultsFetchRequest managedObjectContext:[NSManagedObjectContext defaultManagedObjectContext] sectionNameKeyPath:nil cacheName:@"Categories"];
        fetchedResultsController.delegate = self;
        
        [resultsFetchRequest release];
    }
    
    [fetchedResultsController performFetch:nil];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Spot *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = info.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", 
    //inf, info.state];
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
