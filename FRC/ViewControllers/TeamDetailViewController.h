//
//  TeamDetailViewController.h
//  FRC
//
//  Created by Nick McGuire on 11-10-25.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"
#import "Team.h"

@interface TeamDetailViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NMCustomCell>
{
	NSArray *matches;
}

@property (nonatomic, retain) Team * team;
@property (nonatomic, retain) NSArray * numbers;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
