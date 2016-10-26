//
//  GWHTTPTool.h
//  HpTool
//
//  Created by 魏郭文 on 16/2/16.
//  Copyright © 2016年 魏郭文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWHTTPTool : NSObject

+ (void) getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void) postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end
