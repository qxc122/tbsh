//
//  ToolRequest.m
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest.h"
#import "HeaderAll.h"
#define  RETSTATUSSUCCESS   @"0"
#define  RETSTATUFAILURE   @"-1"

#define REAUESRTIMEOUT      10    //网络请求超时时间


#define PROMPT_FAIL         NSLocalizedString(@"Load failed", @"Load failed")
#define PROMPT_NOTJSON      NSLocalizedString(@"The server returned the wrong data format", @"The server returned the wrong data format")
#define PROMPT_NOTCONNECT   NSLocalizedString(@"Please check your network settings", @"Please check your network settings")


@interface ToolRequest ()
@property (strong, nonatomic) NSString *baseURLStr;

@end

AFNetworkReachabilityStatus Netstatus;
@implementation ToolRequest
+ (ToolRequest *)sharedInstance
{
    static ToolRequest *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
//        1.创建网络状态监测管理者
        AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
//        开启监听，记得开启，不然不走block
        [manger startMonitoring];
//        2.监听改变
        [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            Netstatus = status;
        }];
    });
#ifdef DEBUG
    NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
    if (!strles) {
        [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
        strles = tesetURLAddress;
    }else{
        strles = strles;
    }
    instance.baseURLStr = strles;
#else
    instance.baseURLStr = URLBASIC;
#endif
    return instance;
}

- (void)postJsonWithPath:(NSString *)path
              parameters:(NSMutableDictionary *)parameters
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock
{

    NSString *accessToken = [PortalHelper sharedInstance].token.accessToken;
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    if (accessToken || [path isEqualToString:URLBASIC_tpurseappappIdApply] || [path isEqualToString:URLBASIC_apptokenApply]) {
        if (accessToken) {
            [parameters setObject:accessToken forKey:@"accessToken"];
        }
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.baseURLStr, path];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
#ifdef DEBUG
        NSLog(@"strTmp=%@  path=%@",[parameters DicToJsonstr],urlStr);
#endif
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json",@"text/html", nil];
        
        [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                [self parseResponseData:result
                                success:^(id dataDict, NSString *msg, NSInteger code) {
                                    
                                    successBlock(dataDict, msg, code);
                                }
                                failure:^(NSInteger errorCode, NSString *msg) {
                                    failureBlock(errorCode, msg);
                                }
                 ifRespondDataEncrypted:NO];
            }else{
                failureBlock(KRespondCodeNone, @"服务器返回数据为空");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (Netstatus == AFNetworkReachabilityStatusNotReachable || Netstatus == AFNetworkReachabilityStatusUnknown) {
                failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
            }else{
                NSDictionary *tmp = error.userInfo;
                NSString *tmpStr = tmp[@"NSLocalizedDescription"];
                failureBlock(KRespondCodeFail, tmpStr);
            }
        }];
    }
    
}

//验证返回数据是否正确
- (void)parseResponseData:(id)responseData
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock
   ifRespondDataEncrypted:(BOOL)encryptedReponse
{
    NSMutableDictionary *jsonRootObject = [(NSMutableDictionary *)responseData copy];
    if (jsonRootObject == nil) {
        failureBlock(kRespondCodeNotJson, PROMPT_NOTJSON);
    }else {
        NSString *code = [jsonRootObject valueForKeyPath:@"retStatus"];
        NSString *msg = [jsonRootObject valueForKeyPath:@"errorMsg"];
        if ([code isEqualToString:RETSTATUSSUCCESS]) {
            successBlock(jsonRootObject, msg, 0);
        } else if ([code isEqualToString:RETSTATUFAILURE]) {
            failureBlock(-1, msg);
            NSInteger errorCode = [[jsonRootObject valueForKeyPath:@"errorCode"] integerValue];
            if (errorCode == kRespondCodeExoipDateAccessToken) {    /** Token无效 */
   
            }else if (errorCode == kRespondCodeuserdoesnotexist) {
                [PortalHelper sharedInstance].userInfo = nil;
                NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
        } else {
            failureBlock(KRespondCodeFail, msg);
        }
    }
}


//更新个人资料
- (void)appuserupdateWithAvtor:(UIImage *)avtor
                      progress:(RequestProgress)progressBlock
                       success:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *accessToken = [PortalHelper sharedInstance].token.accessToken;
    [parameters setObject:PORTALCHANNEL forKey:@"channel"];
    [parameters setObject:PORTALACCESSSOURCE forKey:@"accessSource"];
    [parameters setObject:PHONEVERSION forKey:@"accessSourceType"];
    [parameters setObject:PORTALVERSION forKey:@"version"];
    if (accessToken) {
        [parameters setObject:accessToken forKey:@"accessToken"];
    }
    NSDictionary *appRequest = @{
                                 @"sessionContext":[parameters dictionaryToJsonStr],
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
#ifdef DEBUG
    NSLog(@"strTmp=%@  path=%@",[parameters DicToJsonstr],[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_userheadUpload]);
#endif
    //2.上传文件
    [manager POST:[NSString stringWithFormat:@"%@%@", self.baseURLStr, URLBASIC_userheadUpload] parameters:appRequest constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *tmp = avtor;
        //            UIImage *tmp = [UIImage imageNamed:@"1"];
        NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
        CGFloat yasou=0.99;
        while (imageData.length > 1024*1024) {
            tmp = avtor;
            NSLog(@"太大了 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
            imageData = UIImageJPEGRepresentation(tmp, yasou);
            if (imageData.length > 10*1024*1024) {
                yasou *=0.1;
            } else if (imageData.length > 5*1024*1024){
                yasou *=0.2;
            } else if (imageData.length > 4*1024*1024){
                yasou *=0.6;
            } else if (imageData.length > 3*1024*1024){
                yasou *=0.7;
            } else if (imageData.length > 2*1024*1024){
                yasou *=0.8;
            } else if (imageData.length > 1*1024*1024){
                yasou *=0.9;
            }
            NSLog(@"压小后 评价  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
        }
        NSLog(@"imageData.leng=%ld k",imageData.length/1024);
        
        if (imageData.length) {
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"files.png" mimeType:@"image/png"];
        }else{
            failureBlock(-1,NSLocalizedString(@"The picture is empty", @"The picture is empty"));
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
            [self parseResponseData:result
                            success:^(id dataDict, NSString *msg, NSInteger code) {
                                
                                successBlock(dataDict, msg, code);
                            }
                            failure:^(NSInteger errorCode, NSString *msg) {
                                failureBlock(errorCode, msg);
                            }
             ifRespondDataEncrypted:NO];
        }else{
            failureBlock(KRespondCodeNone, NSLocalizedString(@"The server returns the data blank", @"The server returns the data blank"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Netstatus == AFNetworkReachabilityStatusNotReachable || Netstatus == AFNetworkReachabilityStatusUnknown) {
            failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
        }else{
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }
    }];
}

@end
