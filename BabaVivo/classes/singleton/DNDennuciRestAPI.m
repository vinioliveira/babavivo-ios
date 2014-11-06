//
//  DNDennuciRestAPI.m
//
//
//  Created by Vinicius Oliveira on 6/30/14.
//
//
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <FacebookSDK/Facebook.h>
#import "DNDennuciRestAPI.h"
#import "User.h"
#import "FFVSessionControl.h"


#define kDENNUCISERVER @"http://blooming-spire-6046.herokuapp.com"
//#define kDENNUCISERVER @"http://10.71.0.6:3000"

@interface DNDennuciRestAPI()
+(void) initDataBaseConfiguration;
+(void) mappingEntitysRestKit;
+(void) addResponseDescriptor:(RKResponseDescriptor*) descriptor;
@end

@implementation DNDennuciRestAPI

static RKManagedObjectStore* managedObjectStore;
static NSMutableArray* descriptors;

+(NSString *)baseUrlPath
{
    return kDENNUCISERVER;
}

+(void)initRestKitAPI{
    
    
    // Initialize RestKit
    NSURL *baseURL = [NSURL URLWithString:kDENNUCISERVER];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self initDataBaseConfiguration];
    
    objectManager.managedObjectStore = managedObjectStore;
    
    [self mappingEntitysRestKit];
    
    // Register our mappings with the provider
    
    [objectManager addResponseDescriptorsFromArray:descriptors];
    
}


+(void)initDataBaseConfiguration
{
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKTwitter.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
}

+(void)mappingEntitysRestKit
{
    
    RKResponseDescriptor *postReponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self getPostMapping]
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/posts"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self addResponseDescriptor:postReponseDescriptor];
    
    RKResponseDescriptor* userResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self getUserMapping]
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@"/users"
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self addResponseDescriptor:userResponseDescriptor];

    RKResponseDescriptor* userAuthResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[self getUserMapping]
                                                                                                method:RKRequestMethodPOST
                                                                                           pathPattern:@"/api/auth/facebook/mobile"
                                                                                               keyPath:nil
                                                                                           statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self addResponseDescriptor:userAuthResponseDescriptor];
    
}


+(RKEntityMapping *) getPostMapping
{
    RKEntityMapping *postMapping = [RKEntityMapping mappingForEntityForName:@"Post" inManagedObjectStore:managedObjectStore];

    postMapping.identificationAttributes = @[ @"id" ];

    [postMapping addAttributeMappingsFromDictionary:@{
                                                      @"_id": @"id",
                                                      @"publish_date": @"publishedDate",
                                                      @"description": @"legend",
                                                      @"url_image_published": @"urlImagePublished",
                                                      }];

    [postMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"user" toKeyPath:@"user" withMapping:[self getUserMapping]]];

    return postMapping;
}

+(RKEntityMapping *) getUserMapping
{
    RKEntityMapping *userMapping = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:managedObjectStore];
    
    userMapping.identificationAttributes = @[ @"id" ];
    [userMapping addAttributeMappingsFromDictionary:@{@"_id": @"id"}];
    [userMapping addAttributeMappingsFromArray:@[
                                                 @"firstName",
                                                 @"lastName",
                                                 @"username",
                                                 @"facebookUserId",
                                                 @"apiAccessToken",
                                                 @"email",
                                                 @"avatar",
                                                 ]];
    
    return userMapping;

}

+(void)addResponseDescriptor:(RKResponseDescriptor*) descriptor
{
    if (!descriptors) {
        descriptors = [[NSMutableArray alloc] init];
    }
    
    [descriptors addObject:descriptor];
}

+(void)authenticateUser:(void (^)(User *))success failure:(void (^)(NSError *))failure
{
    NSString  * accessToken  = [FBSession activeSession].accessTokenData.accessToken;

    NSString *urlPath = @"/api/auth/facebook/mobile";

    [[RKObjectManager sharedManager] postObject:nil path:urlPath
                                     parameters:@{@"facebookToken": accessToken, @"appName" : @"Dennuci"}
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            User *currentUser =  [mappingResult.array firstObject];
                                            if (success) {
                                                success(currentUser);
                                            }
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            if (failure) {
                                                failure(error);
                                            }
                                        }];
}

@end
