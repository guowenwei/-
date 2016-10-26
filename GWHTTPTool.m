//
//  GWHTTPTool.m
//  HpTool
//
//  Created by 魏郭文 on 16/2/16.
//  Copyright © 2016年 魏郭文. All rights reserved.
//

#import "GWHTTPTool.h"


@implementation GWHTTPTool

+ (void) getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure {
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 发生请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void) postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure {
    // AFNetWorking
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 发生请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            UIWindow * window = [UIApplication sharedApplication].keyWindow;
            for (UIView * view in window.subviews) {
                if ([[view class] isSubclassOfClass:[GWAlertView class]])
                {
                    [view removeFromSuperview];
                }
            }
            GWAlertView * alert = [[GWAlertView alloc] initWithShowType:(GWAlertViewStyleOneBtn) backColor:kBtnBackgroundColor Title:@"温馨提示" message:@"数据请求出错啦" cancelBtnStr:@"确定" sureBtnStr:nil];
            [alert show];
        }
    }];
    
}

@end
