//
//  Match.h
//  FRC
//
//  Created by Nick McGuire on 12-02-02.
//  Copyright (c) 2012 RND Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Match : NSManagedObject

@property (nonatomic, retain) NSNumber * blueScore;
@property (nonatomic, retain) NSNumber * matchNumber;
@property (nonatomic, retain) NSNumber * redScore;
@property (nonatomic, retain) NSSet *redTeams;
@property (nonatomic, retain) NSSet *blueTeams;
@end

@interface Match (CoreDataGeneratedAccessors)

- (void)addRedTeamsObject:(Team *)value;
- (void)removeRedTeamsObject:(Team *)value;
- (void)addRedTeams:(NSSet *)values;
- (void)removeRedTeams:(NSSet *)values;

- (void)addBlueTeamsObject:(Team *)value;
- (void)removeBlueTeamsObject:(Team *)value;
- (void)addBlueTeams:(NSSet *)values;
- (void)removeBlueTeams:(NSSet *)values;

@end
