//
//  AppDelegate.h
//  FRC
//
//  Created by Nick McGuire on 11-10-17.
//  Copyright (c) 2011 RND Consulting. All rights reserved.
//

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>


@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSManagedObjectContext *)currentObjectContext;

@end
