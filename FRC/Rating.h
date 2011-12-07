//
//  Rating.h
//  FRC
//
//  Created by Nick McGuire on 11-12-04.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Rating : NSManagedObject

@property (nonatomic, retain) NSNumber * autonomousRating;
@property (nonatomic, retain) Team *team;

@end
