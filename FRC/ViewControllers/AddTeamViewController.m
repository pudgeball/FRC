//
//  AddTeamViewController.m
//  FRC
//
//  Created by Nick McGuire on 11-10-20.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import "AddTeamViewController.h"
#import "Team.h"
#import "Details.h"
#import "CustomCell.h"

@implementation AddTeamViewController

@synthesize managedObjectContext = __managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
        // Custom initialization
		currentObjects = [[NSMutableArray alloc] init];
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
	
	[[self navigationItem] setTitle:@"Add Team"];
	
	newTeam = [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:[self managedObjectContext]];
	//newTeamDetails = [NSEntityDescription insertNewObjectForEntityForName:@"Details" inManagedObjectContext:[self managedObjectContext]];
	//[newTeamDetails setTeam:newTeam];
	
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																				target:self
																				action:@selector(doneAdd)];
	
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																				  target:self
																				  action:@selector(closeWindow)];
	[[self navigationItem] setRightBarButtonItem:doneButton];
	[[self navigationItem] setLeftBarButtonItem:cancelButton];
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
	//return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

#pragma mark - User Methods

- (void)collectData
{
	NSLog(@"Oh dear: %d", [currentObjects count]);
	
	for (id object in currentObjects)
	{
		if ([object isKindOfClass:[UISwitch class]])
		{
			if ([object tag] == 2)
			{
				//[newTeamDetails setHasAutonomous:[NSNumber numberWithInt:[object isOn]?1:0]];
			}
		}
		else if ([object isKindOfClass:[UITextField class]])
		{
			[self textFieldShouldReturn:object];
		}
	}
}

- (void)closeWindow
{
	[[self navigationController] dismissModalViewControllerAnimated:YES];
}

- (void)doneAdd
{
	[self collectData];
	
	NSError *error;
	if (![[self managedObjectContext] save:&error])
		NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
	
	[self closeWindow];
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
			return 2;
			break;
		case 1:
			return 1;
			break;
		default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdent"];
	
	if (cell == nil)
	{
		cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdent"];
		
		switch (indexPath.section)
		{
			case 0:
				switch (indexPath.row)
				{
					case 0:
						[cell setUpTextFieldWithPlaceholder:@"Name" AndTag:0];
						break;
					case 1:
						[cell setUpTextFieldWithPlaceholder:@"Number" AndTag:1];
						break;
				}
				break;
			case 1:
				switch (indexPath.row)
				{
					case 0:
						[cell setUpSwitchWithTag:2];
						break;
				}
				break;
		}
    
		[[cell cellTextField] setDelegate:self];
		[currentObjects addObject:[cell getCurrentObject]];
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
			return @"Team Details";
			break;
		default:
			return @"err";
			break;
	}
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	switch ([textField tag])
	{
		case 0:
			[newTeam setName:[textField text]];
			NSLog(@"%@", [textField text]);
			break;
		case 1:
			[newTeam setNumber:[NSNumber numberWithInt:[textField.text intValue]]];
			NSLog(@"%@", [newTeam number]);
			break;
		default:
			NSLog(@"err");
			break;
	}
	
	return YES;
}

@end
