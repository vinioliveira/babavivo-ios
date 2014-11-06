//
//  FFVSessionControl.h
//  IOS-App
//
//  Created by Vinicius Oliveira on 8/16/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface FFVSessionControl : NSObject
+(void)authenticateUser:(void (^)(User *))success failure:(void (^)(NSError *))failure;
+(User*) currentUser;
+(void) setCurrentUser:(User*) user;
@end
