//
//  SSViewController.m
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/11/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "SSViewController.h"
#import "AppDelegate.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"

@implementation SSViewController

@synthesize HUD;
@synthesize myTableView;
@synthesize fetchedResultsController;
@synthesize sortDescriptors;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self initHUD];
        self.myTableView.backgroundColor = [UIColor clearColor];
        self.myTableView.separatorColor = [UIColor lightGrayColor];
        
        /*
         NSSortDescriptor *nameSort = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
         NSSortDescriptor *accountSort = [[NSSortDescriptor alloc] initWithKey:@"account" ascending:YES];
         
        self.sortDescriptors = [NSArray arrayWithObjects:nameSort, accountSort, nil];
         */
       
        
    }
    return self;
}

-(void) dealloc {
    HUD.delegate = nil;
    [HUD hide:YES];
    SafeRelease(HUD);
    SafeRelease(myTableView);
    SafeRelease(sortDescriptors);
    SafeRelease(fetchedResultsController);
    [super dealloc];
}

-(void) initHUD {
    
    self.HUD = [[MBProgressHUD alloc] initWithWindow:((AppDelegate *)[[UIApplication sharedApplication] delegate]).window];
    self.HUD.delegate = self;
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window addSubview:self.HUD];
	
}


- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    
    [self.HUD removeFromSuperview];
    
}
/*
 * generic method to get some results for the tableview
 */

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

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = 
    [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    /*
    FailedBankInfo *info = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", 
                                 info.city, info.state];
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = 
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle 
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.myTableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.myTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.myTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.myTableView endUpdates];
}


/*
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath  {
    [cell.textLabel setFont:FONT_MAIN];
    [cell.detailTextLabel setFont:FONT_DETAIL];
}
 */
@end
