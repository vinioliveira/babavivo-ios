//
//  Post.h
//  Denucie
//
//  Created by Vinicius Oliveira on 7/1/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Post : NSManagedObject

@property (nonatomic, retain) NSString * publishedDate;
@property (nonatomic, retain) NSString * legend;
@property (nonatomic, retain) NSString * urlImagePublished;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) User *user;

@end
