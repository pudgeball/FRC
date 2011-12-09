//
//  AddMatchViewController.m
//  FRC
//
//  Created by Nick McGuire on 11-12-07.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import "AddMatchViewController.h"
#import "TeamList.h"

#import "Match.h"

@interface AddMatchViewController()
- (void)closeWindow;
@end

@implementation AddMatchViewController

@synthesize managedObjectContext = __managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
        // Custom initialization
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
	
	[[self navigationItem] setTitle:@"Add Match"];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
																				target:self 
																				action:@selector(doneAdd)];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																				  target:self 
																				  action:@selector(closeWindow)];
	[[self navigationItem] setRightBarButtonItem:doneButton];
	[[self navigationItem] setLeftBarButtonItem:cancelButton];
	
	newMatch = [NSEntityDescription insertNewObjectForEntityForName:@"Match" inManagedObjectContext:[self managedObjectContext]];
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

- (void)doneAdd
{
	[self closeWindow];
}

- (void)closeWindow
{
	NSLog(@"Dump-Match: %@", newMatch);
	
	NSError *error;
	if (![[self managedObjectContext] save:&error])
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section)
	{
		case 0:
			return 3;
			break;
		case 1:
			return 1;
			break;
		case 2:
			return 1;
			break;
		default:
			return 2;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	static NSString *CustomIdentifier = @"Custom";
	
	CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:CustomIdentifier];
	if (customCell == nil)
	{
		customCell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomIdentifier];
		[customCell setDelegate:self];
		
		switch ([indexPath section])
		{
			case 0:
				switch ([indexPath row]) {
					case 0:
						[customCell setUpTextFieldWithPlaceholder:@"Match Number" AndTag:0];
						break;
					case 1:
						[customCell setUpTextFieldWithPlaceholder:@"Blue Score" AndTag:1];
						break;
					case 2:
						[customCell setUpTextFieldWithPlaceholder:@"Red Score" AndTag:2];
						break;
				}
				break;
		}
	}
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	
	switch ([indexPath section])
	{
		case 0:
			return customCell;
			break;
		case 1:
			[[cell textLabel] setText:@"Blue Teams"];
			break;
		case 2:
			[[cell textLabel] setText:@"Red Teams"];
			break;
	}
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
	
	TeamList *testIdea = [[TeamList alloc] init];
	[[self navigationController] pushViewController:testIdea animated:YES];
}

#pragma mark - NMCustomCellDelegate

- (void)currentCellDidUpdate:(NSString *)data withTag:(NSInteger)tag
{
	switch (tag)
	{
		case 0:
			[newMatch setMatchNumber:[NSNumber numberWithInt:[data intValue]]];
			break;
		case 1:
			[newMatch setBlueScore:[NSNumber numberWithInt:[data intValue]]];
			break;
		case 2:
			[newMatch setRedScore:[NSNumber numberWithInt:[data intValue]]];
			break;
	}
}

@end