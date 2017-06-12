//
//  YSHTTPRequestManager.m
//  Car
//
//  Created by MACOS01 on 2017/4/25.
//  Copyright © 2017年 MACOS01. All rights reserved.
//

#import "YSHTTPRequestManager.h"

@implementation YSHTTPRequestManager

static id _instance = nil;

+ (instancetype)sharedHTTPRequest{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (instancetype)init {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    // 位置网络
                    NSLog(@"位置网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    // 无法联网
                    NSLog(@"无法联网");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    // 手机自带网络
                    NSLog(@"当前使用的是2G/3G/4G网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    // WIFI
                    NSLog(@"当前在WIFI网络下");
                }
            }
        }];
//        [manager startMonitoring];
    });
    return _instance;
}


#pragma mark  > GET 请求时调用的方法 <
- (void)GETWithURL:(NSString *)strURL withParam:(NSDictionary *)dictParam andRequestSuccess:(void (^)(id responseObject))blkRequestSuccess andRequestFailure:(void (^)(NSError *error))blkRequestFailure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  可以接受的类型
     */
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置响应的接收类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    /**
     *  请求队列的最大并发数
     */
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 10;
    [manager GET:strURL parameters:dictParam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求成功时调用
        //        NSLog(@"%@",responseObject);
        blkRequestSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求失败时调用
        blkRequestFailure(error);
    }];
}

#pragma mark  > POST 请求时调用的方法 <
- (void)POSTWithURL:(NSString *)strURL withParam:(NSDictionary *)dictParam andRequestSuccess:(void (^)(id responseObject))blkRequestSuccess andRequestFailure:(void (^)(NSError *error))blkRequestFailure{
    //    // 创建一个 HTTP管理
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  请求超时的时间
     */
    manager.requestSerializer.timeoutInterval = 8;
//    manager.operationQueue.maxConcurrentOperationCount = 3;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置响应的接收类型
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    
    [manager POST:strURL parameters:dictParam progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求成功时调用
        //        NSLog(@"%@",responseObject);
        blkRequestSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求失败时调用
        blkRequestFailure(error);
    }];
}

- (void)uploadWithURL:(NSString *)strURL withParam:(NSDictionary *)dictParam withImage:(UIImage *)image andFileName:(NSString *)fileName WithName:(NSString *)name progerss:(void (^)(NSProgress *uploadProgress))progress andRequestSuccess:(void (^)(id))blkRequestSuccess andRequestFailure:(void (^)(NSError *))blkRequestFailure{
    if (strURL == nil) {
        return ;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // 设置返回的数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = 10;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
//                         @"text/html",
//                         @"text/json",
//                         @"text/plain",
//                         @"text/javascript",
//                         @"text/xml",
//                         @"image/*",nil];
    
    [manager POST:strURL parameters:dictParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 压缩图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSString *imageFileName = fileName;
        if (fileName == nil || ![fileName isKindOfClass:[NSString class] ] || fileName.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@",str];
        }
        // 上传图片以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 网络请求成功时调用
        //        NSLog(@"%@",responseObject);
        if (blkRequestSuccess) {
            blkRequestSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 网络请求失败时调用
        if (blkRequestFailure) {
            blkRequestFailure(error);
        }
    }];
    
    
}

#pragma mark - 下载数据
- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)())progress success:(void (^)())success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress();
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return targetPath;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (failure) {
            failure(error);
        }
    }];
    [downLoadTask resume];
}

//+ (NSString *)strUTF8Encoding:(NSString *)str{
//    return [str stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
//}

@end
