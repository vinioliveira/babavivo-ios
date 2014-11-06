//
//  DNDennuciRestAPI.h
//  
//
//  Created by Vinicius Oliveira on 6/30/14.
//
//

#import <RestKit/RestKit.h>
#import <Foundation/Foundation.h>
#import "User.h"

@interface DNDennuciRestAPI : NSObject
+(void) initRestKitAPI;
+(RKEntityMapping *) getUserMapping;
+(NSString *) baseUrlPath;
+(void)authenticateUser:(void (^)(User *))success failure:(void (^)(NSError *))failure;
@end
