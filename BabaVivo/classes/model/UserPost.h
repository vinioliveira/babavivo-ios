//
//  UserPost.h
//  Denucie
//
//  Created by Vinicius Oliveira on 6/11/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPost : NSObject

@property (nonatomic, strong) NSString* user;
@property (nonatomic, strong) UIImage* avatar;
@property (nonatomic, strong) UIImage* postPicture;

-(id)initWithName:(NSString*) name avatar:(NSString *) nameImageAvatar post:(NSString*) namePostImage; 

@end
