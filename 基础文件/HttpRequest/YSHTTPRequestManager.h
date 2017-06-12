//
//  YSHTTPRequestManager.h
//  Car
//
//  Created by MACOS01 on 2017/4/25.
//  Copyright © 2017年 MACOS01. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 网络请求*/
#import "AFNetWorking.h"

#import "YSStatusBarTool.h"

@interface YSHTTPRequestManager : NSObject

/** 创建的单例*/
+ (instancetype)sharedHTTPRequest;


/** post 请求时使用的方法*/
- (void)POSTWithURL:(NSString *)strURL
          withParam:(NSDictionary *)dictParam
  andRequestSuccess:(void(^)(id responseObject))blkRequestSuccess
  andRequestFailure:(void(^)(NSError *error)) blkRequestFailure;

/** get 请求时用的方法*/
- (void)GETWithURL:(NSString *)strURL
         withParam:(NSDictionary *)dictParam
 andRequestSuccess:(void(^)(id responseObject))blkRequestSuccess
 andRequestFailure:(void(^)(NSError *error)) blkRequestFailure;

/** 
 *上传图片
 
 *@param image 上传的图片
 *@param  fileName  图片的名称 （如果不传 会以当前时间命名）
 *@param   name 上传图片时填写的对应的参数的名字   后台可以根据这个名字来找到图片
 *@param progress 上传的进度
 
 */
- (void)uploadWithURL:(NSString *)strURL
            withParam:(NSDictionary *)dictParam
            withImage:(UIImage *)image
          andFileName:(NSString *)fileName
             WithName:(NSString *)name
             progerss:(void (^)(NSProgress *uploadProgress))progress
    andRequestSuccess:(void(^)(id responseObject))blkRequestSuccess
    andRequestFailure:(void(^)(NSError *error)) blkRequestFailure;

/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)())progress
                      success:(void (^)())success
                      failure:(void (^)(NSError *error))failure;

@end
