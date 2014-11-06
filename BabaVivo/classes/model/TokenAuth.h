//
//  TokenAuth.h
//  IOS-App
//
//  Created by Vinicius Oliveira on 8/17/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenAuth : NSObject

@property (nonatomic, strong) NSString* facebookToken;
@property (nonatomic, strong) NSString* appName;

- (id)initWithToken:(NSString *) token;
@end
