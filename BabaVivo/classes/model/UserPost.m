//
//  UserPost.m
//  Denucie
//
//  Created by Vinicius Oliveira on 6/11/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "UserPost.h"

@implementation UserPost

@synthesize user = _user;
@synthesize avatar = _avatar;
@synthesize postPicture = _postPicture;

-(id)initWithName:(NSString *)name avatar:(NSString *)nameImageAvatar post:(NSString *)namePostImage
{
    self = [super init];
    if (self) {
        _user = name;
        _avatar = [UIImage imageNamed:nameImageAvatar];
        _postPicture = [UIImage imageNamed:namePostImage];
    }
    
    return self;
}

@end
