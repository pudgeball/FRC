//
//  SelectorViewController.h
//  FRC
//
//  Created by Nick McGuire on 12-02-08.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectorViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
