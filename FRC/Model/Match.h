//
//  Match.h
//  FRC
//
//  Created by Nick McGuire on 11-12-04.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Match : NSManagedObject

@property (nonatomic, retain) NSNumber * blueScore;
@property (nonatomic, retain) NSNumber * matchNumber;
@property (nonatomic, retain) NSNumber * redScore;
@property (nonatomic, retain) NSSet *teams;
@end

@interface Match (CoreDataGeneratedAccessors)

- (void)addTeamsObject:(Team *)value;
- (void)removeTeamsObject:(Team *)value;
- (void)addTeams:(NSSet *)values;
- (void)removeTeams:(NSSet *)values;

@end
