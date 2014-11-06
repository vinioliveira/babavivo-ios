//
//  FFVAppDelegate.h
//  Denucie
//
//  Created by Vinicius Oliveira on 6/11/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
