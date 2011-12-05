//
//  AddTeamViewController.h
//  FRC
//
//  Created by Nick McGuire on 11-10-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Team, Details;

@interface AddTeamViewController : UITableViewController <UITextFieldDelegate>
{
	Team *newTeam;
	Details *newTeamDetails;
	NSMutableArray *currentObjects;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
