//
//  CoreDataHelper.h
//  StepCar
//
//  Created by Vinicius Oliveira on 5/20/14.
//  Copyright (c) 2014 Vinicius Oliveira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject
+(NSManagedObjectContext *) getManagedObjectContext;
+ (void)useContextMocked:(BOOL)isTesting;
@end
