//
//  User.h
//  IOS-App
//
//  Created by Vinicius Oliveira on 8/16/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Post;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * facebookUserId;
@property (nonatomic, retain) NSString * apiAccessToken;
@property (nonatomic, retain) NSDate * timeRelaseAcessToken;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSSet *posts;

@property (nonatomic, strong) NSString* facebookToken;
@property (nonatomic, strong) NSString* appName;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPostsObject:(Post *)value;
- (void)removePostsObject:(Post *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

@end
