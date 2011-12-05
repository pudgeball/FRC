//
//  FirstViewController.m
//  FRC
//
//  Created by Nick McGuire on 11-10-17
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "AddTeamViewController.h"
#import "TeamDetailViewController.h"

#import "Team.h"
#import "Details.h"
#import "Match.h"

@implementation FirstViewController

@synthesize fetchedResultsController = __fetchedResultsController,
				managedObjectContext = __managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self setTitle:@"Teams"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTeam)];
	
	self.navigationItem.rightBarButtonItem = addButton;
	self.navigationItem.leftBarButtonItem = refreshButton;
	
	BOOL yeahyeah = NO;
	Team *newTeam;
	
	if (yeahyeah) {
		newTeam = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:[self managedObjectContext]];
		Team *newTeamTwo = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:[self managedObjectContext]];
		Match *newMatch = [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:[self managedObjectContext]];
	
		newTeam.name = @"testTeam";
		newTeam.number = [NSNumber numberWithInt:1334];
	
		newMatch.teams = [NSSet setWithObjects:newTeam, newTeamTwo, nil];
	
		NSError *error;
		if (![[self managedObjectContext] save:&error]) {
			NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
		}
	}
	/*
	 NSManagedObjectContext *context = [restaurant managedObjectContext];
	 
	 
	 NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	 [fetchRequest setEntity:[NSEntityDescription entityForName:@"Category" inManagedObjectContext:context]];
	 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	 NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	 [fetchRequest setSortDescriptors:sortDescriptors];
	 
	 NSError *error = nil;
	 NSArray *possibleCategories = [context executeFetchRequest:fetchRequest error:&error];
	 
	 categoryArray = [[NSMutableArray alloc] initWithArray:possibleCategories];
	 
	 currentCategories = [restaurant valueForKeyPath:@"categories"];
	 
	 [restaurant addCategoriesObject:(Category *)[possibleCategories objectAtIndex:15 ]];
	 
	 [currentCategories addObject:(Category*)[categoryArray objectAtIndex:15]];
	 
	 */
	
	//NSManagedObjectContext *context = [newTeam managedObjectContext];
	
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Match" inManagedObjectContext:[self managedObjectContext]]];
	
	NSError *errorOut = nil;
	NSArray *possibleCategories = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&errorOut];
	
	if ([possibleCategories count] > 0) {
		Match *testIdea = [possibleCategories objectAtIndex:0];
	
		NSLog(@"possible: %@", testIdea.blueScore);
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[[self tableView] reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)addTeam {
	AddTeamViewController *addTeamVC = [[AddTeamViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[addTeamVC setManagedObjectContext:[self managedObjectContext]];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addTeamVC];
	[[self navigationController] presentModalViewController:navController animated:YES];
}

- (void)refresh {
	[[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellIdentifier = @"MyIdent";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
	Team *team = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	
	[[cell textLabel] setText:[team name]];
	[[cell detailTextLabel] setText:[[team number] stringValue]];
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Team *team = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	
	[[cell textLabel] setText:[team name]];
	[[cell detailTextLabel] setText:[[team number] stringValue]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	TeamDetailViewController *teamDetail = [[TeamDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	 Team *team = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	[teamDetail setTeam:team];
	[[self navigationController] pushViewController:teamDetail animated:YES];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
		case NSFetchedResultsChangeUpdate:
			[self configureCell:[[self tableView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[[self tableView] endUpdates];
}

- (NSFetchedResultsController *)fetchedResultsController
{
	
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:@"Master"];
    [aFetchedResultsController setDelegate:self];
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
		 
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}



@end