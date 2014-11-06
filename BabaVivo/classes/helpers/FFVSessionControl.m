//
//  FFVSessionControl.m
//  IOS-App
//
//  Created by Vinicius Oliveira on 8/16/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "FFVSessionControl.h"
#import "User.h"
#import <RestKit/RestKit.h>
#import <FacebookSDK/Facebook.h>
#import "TokenAuth.h"
#import "DNDennuciRestAPI.h"

@implementation FFVSessionControl

static User * currentUser;

+(void)authenticateUser:(void (^)(User *))success failure:(void (^)(NSError *))failure 
{
    
    
    [DNDennuciRestAPI authenticateUser:^(User *user) {

        [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Authorization" value:user.apiAccessToken];
        [[RKObjectManager sharedManager].HTTPClient setDefaultHeader:@"Userid" value:user.id];
        if (success) {
            success(user);
        }
        
    } failure:^(NSError * error){
        if (failure) {
            failure(error);
        }
    }];
    
    


}

+(User *)currentUser
{
    if (currentUser)
    {
        return currentUser;
    }
    else
    {
        return nil;
    }
}

+(void)setCurrentUser:(User *)user
{
    if (user) {
        NSLog(@"Novo usuário autenticado : %@", user.username);
        currentUser = user;
    }
}
@end
