//
//  FirstViewController.h
//  FRC
//
//  Created by Nick McGuire on 11-10-17.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

@interface FirstViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
