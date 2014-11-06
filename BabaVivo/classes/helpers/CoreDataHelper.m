//
//  CoreDataHelper.m
//  StepCar
//
//  Created by Vinicius Oliveira on 5/20/14.
//  Copyright (c) 2014 Vinicius Oliveira. All rights reserved.
//

#import "CoreDataHelper.h"
#import "FFVAppDelegate.h"

@interface CoreDataHelper()
+ (NSManagedObjectContext *)getManagedObjectContextTest;
@end

@implementation CoreDataHelper

static BOOL _isTesting;
static NSManagedObjectContext * contextMocked;

+ (NSManagedObjectContext *) getManagedObjectContext {
 
    if (_isTesting) {
        return [self getManagedObjectContextTest];
    }
    
    FFVAppDelegate *delegate =
    (FFVAppDelegate *)
    [[UIApplication sharedApplication] delegate];
    return [delegate managedObjectContext];
}

+ (NSManagedObjectContext *)getManagedObjectContextTest
{
    if (contextMocked) {
        return contextMocked;
    }
    NSError* error;
    // ObjectModel from any models in app bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // Coordinator with in-mem store type
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:&error];
    
    // Context with private queue (for example)
    contextMocked = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    contextMocked.persistentStoreCoordinator = coordinator;
    
    return contextMocked;
}

+ (void)useContextMocked:(BOOL)isTesting
{
    if(!isTesting)
    {
        contextMocked = nil;
    }
    
    _isTesting = isTesting;
}
@end
