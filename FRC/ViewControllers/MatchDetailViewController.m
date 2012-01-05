//
//  MatchDetailViewController.m
//  FRC
//
//  Created by Nick McGuire on 11-12-10.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import "MatchDetailViewController.h"

#import "TeamDetailViewController.h"

#import "Team.h"
#import "Match.h"


@implementation MatchDetailViewController

@synthesize match;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
	
	[[self navigationItem] setTitle:[NSString stringWithFormat:@"Match %@", [match matchNumber]]];
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
	
	teamsInMatch = [[NSArray alloc] initWithArray:[match teams].allObjects];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
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
			return [teamsInMatch count];
			break;
		default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
	
	NSString *mainText;
	NSString *subText;
	Team *team;
	
	switch ([indexPath section])
	{
		case 0:
			switch ([indexPath row])
			{
				case 0:
					mainText = [NSString stringWithFormat:@"Match %@", [match matchNumber]];
					subText = @"Match Number";
					break;
				case 1:
					mainText = [NSString stringWithFormat:@"Blue Score: %@", [match blueScore]];
					break;
				case 2:
					mainText = [NSString stringWithFormat:@"Red Score: %@", [match redScore]];
					break;
			}
			break;
		case 1:
			team = [teamsInMatch objectAtIndex:indexPath.row];
			mainText = [NSString stringWithFormat:@"%@", [team name]];
			subText = [NSString stringWithFormat:@"Team %@", [team number]];
			[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
			break;
	}
	
	[[cell textLabel] setText:mainText];
	[[cell detailTextLabel] setText:subText];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section)
	{
		case 0:
			return @"Match Info";
			break;
		case 1:
			return @"Teams";
			break;
		default:
			return @"err";
			break;
	}
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1)
	{
		TeamDetailViewController *teamDetail = [[TeamDetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
		[teamDetail setTeam:[teamsInMatch objectAtIndex:indexPath.row]];
		[[self navigationController] pushViewController:teamDetail animated:YES];
	}
}

@end
