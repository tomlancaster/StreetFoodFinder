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

@implementation CategoryViewController

@synthesize landscapeView;
@synthesize portraitView;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) dealloc {
    SafeRelease(landscapeView);
    SafeRelease(portraitView);
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
        [resultsFetchRequest setEntity:[[NSManagedObjectContext defaultManagedObjectContext] entityDescriptionForName:@"Example"]];
        
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
    [self findResults];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
