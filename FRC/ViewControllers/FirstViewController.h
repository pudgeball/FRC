//
//  FirstViewController.h
//  FRC
//
//  Created by Nick McGuire on 11-10-17.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@interface FirstViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
