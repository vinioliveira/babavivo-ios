//
//  TokenAuth.m
//  IOS-App
//
//  Created by Vinicius Oliveira on 8/17/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "TokenAuth.h"

@implementation TokenAuth

@synthesize facebookToken = _facebookToken;
@synthesize appName = _appName;

- (id)initWithToken:(NSString *) token
{
    self = [super init];
    
    if (self) {
        _facebookToken = token;
        _appName = @"Dennuci";
    }
    
    return self;
}

@end
