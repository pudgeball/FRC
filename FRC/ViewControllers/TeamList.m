//
//  TeamList.m
//  FRC
//
//  Created by Nick McGuire on 11-12-08.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import "TeamList.h"
#import "AppDelegate.h"

#import "Team.h"

@implementation TeamList

@synthesize fetchedResultsController = __fetchedResultsController,
				managedObjectContext = __managedObjectContext;

@synthesize hasFinished, selectedTeams;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
        // Custom initialization
		numSelected = 0;
		hasFinished = NO;
		selectedTeams = [[NSMutableArray alloc] init];
		[[self navigationItem] setTitle:@"Teams"];
    }
    return self;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
	
	if ([selectedTeams count] == 3)
		hasFinished = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
	return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
	
	Team *displayTeam = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	[[cell textLabel] setText:[NSString stringWithFormat:@"Team %@", [displayTeam number].stringValue]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	Team *selectedTeam = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	
	if (numSelected < 3)
	{
		if (cell.accessoryType != UITableViewCellAccessoryCheckmark)
		{
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
			numSelected++;
			[selectedTeams addObject:selectedTeam];
		} 
		else
		{
			[cell setAccessoryType:UITableViewCellAccessoryNone];
			numSelected--;
			[selectedTeams removeObject:selectedTeam];
		}
	}
	else
	{
		if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
		{
			[cell setAccessoryType:UITableViewCellAccessoryNone];
			numSelected--;
			[selectedTeams removeObject:selectedTeam];
		}
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
        return __fetchedResultsController;
    
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Team" inManagedObjectContext:[delegate managedObjectContext]];
    [fetchRequest setEntity:entity];
	
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[delegate managedObjectContext] sectionNameKeyPath:nil cacheName:@"Master"];
    [aFetchedResultsController setDelegate:self];
    self.fetchedResultsController = aFetchedResultsController;
    
	delegate = nil;
	
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error])
	{
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
