//
//  TeamDetailViewController.m
//  FRC
//
//  Created by Nick McGuire on 11-10-25.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import "TeamDetailViewController.h"

#import "Match.h"

#import "MatchDetailViewController.h"

@implementation TeamDetailViewController

@synthesize managedObjectContext = __managedObjectContext;

@synthesize team, numbers;

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

- (void)currentCellDidUpdate:(NSString *)data withTag:(NSInteger)tag
{
	NSLog(@"Receieved Data: %@", data);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
	
	numbers = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
	matches = [[NSArray alloc] initWithArray:[team match].allObjects];
	
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
	
	[self setTitle:[NSString stringWithFormat:@"Team %@", [team number]]];
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
    return YES;
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
			return 2;
			break;
		case 1:
			return 1;
			break;
		case 2:
			return [matches count];
			break;
		default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	static NSString *CustomIdent = @"Custom";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	CustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:CustomIdent];
	
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	if (customCell == nil)
	{
		customCell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomIdent];
		[customCell setDelegate:self];
		
		switch (indexPath.section)
		{
			case 0:
				break;
			case 1:
				switch (indexPath.row)
				{
					case 0:
						[customCell setUpSegmentedControlWithTitles:numbers AndTag:0];
						customCell.cellSegControl.selectedSegmentIndex = 0;
						break;
				}
				break;
		}
	}
	
    // Configure the cell...
	
	Match *match;
	
	switch (indexPath.section)
	{
		case 0:
			switch (indexPath.row)
			{
				case 0:
					[[cell textLabel] setText:[team name]];
					[[cell detailTextLabel] setText:@"Name"];
					break;
				case 1:
					[[cell textLabel] setText:[[team number] stringValue]];
					[[cell detailTextLabel] setText:@"Number"];
					break;
			}
			break;
		case 1:
			return customCell;
			break;
		case 2:
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			match = [matches objectAtIndex:indexPath.row];
			[[cell textLabel] setText:[NSString stringWithFormat:@"Match %@", [match matchNumber]]];
			break;
	}
	
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section)
	{
		case 0:
			return @"Team Info";
			break;
		case 1:
			return @"Details";
			break;
		case 2:
			return @"Matches";
		default:
			return @"err";
			break;
	}
}

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
	
	MatchDetailViewController *matchDetail = [[MatchDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[matchDetail setMatch:[matches objectAtIndex:indexPath.row]];
	[[self navigationController] pushViewController:matchDetail animated:YES];
	
}

@end
