//
//  MatchDetailViewController.h
//  FRC
//
//  Created by Nick McGuire on 11-12-10.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Match;

@interface MatchDetailViewController : UITableViewController
{
	NSArray *teamsInMatch;
}

@property (strong, nonatomic) Match *match;

@end
