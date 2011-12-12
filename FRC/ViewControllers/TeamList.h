//
//  TeamList.h
//  FRC
//
//  Created by Nick McGuire on 11-12-08.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamList : UITableViewController <NSFetchedResultsControllerDelegate>
{
	int numSelected;
	BOOL hasFinished;
	
	NSMutableArray *selectedTeams;
}

@property (nonatomic) BOOL hasFinished;
@property (strong, nonatomic) NSMutableArray *selectedTeams;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
