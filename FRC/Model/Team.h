//
//  Team.h
//  FRC
//
//  Created by Nick McGuire on 11-12-04.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Details, Match, Rating;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSSet *match;
@property (nonatomic, retain) Details *teamDetails;
@property (nonatomic, retain) NSSet *teamQuestions;
@property (nonatomic, retain) NSSet *teamRating;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addMatchObject:(Match *)value;
- (void)removeMatchObject:(Match *)value;
- (void)addMatch:(NSSet *)values;
- (void)removeMatch:(NSSet *)values;

- (void)addTeamQuestionsObject:(NSManagedObject *)value;
- (void)removeTeamQuestionsObject:(NSManagedObject *)value;
- (void)addTeamQuestions:(NSSet *)values;
- (void)removeTeamQuestions:(NSSet *)values;

- (void)addTeamRatingObject:(Rating *)value;
- (void)removeTeamRatingObject:(Rating *)value;
- (void)addTeamRating:(NSSet *)values;
- (void)removeTeamRating:(NSSet *)values;

@end
