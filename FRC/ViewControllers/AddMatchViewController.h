//
//  AddMatchViewController.h
//  FRC
//
//  Created by Nick McGuire on 11-12-07.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@class Match;

@interface AddMatchViewController : UITableViewController <NMCustomCell>
{
	Match *newMatch;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
