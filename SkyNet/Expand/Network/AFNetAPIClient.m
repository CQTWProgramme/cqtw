//
//  AFNetAPIClient.m
//  AFNetworking3
//
//  Created by wyq on 16/5/10.
//  Copyright © 2016年 永强. All rights reserved.
//

#import "AFNetAPIClient.h"

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO


@interface AFNetAPIClient ()

@property (nonatomic,copy)NSString * url;
@property (nonatomic,assign)NetworkMethod wRequestType;
@property (nonatomic,strong)NSData * Wyqfile_data;
@property (nonatomic,copy)NSString * Wyqname;
@property (nonatomic,copy)NSString * Wyqfilename;
@property (nonatomic,copy)NSString * WyqmimeType;
@property (nonatomic,copy)id parameters;
@property (nonatomic,copy)NSDictionary * wHTTPHeader;

@end
@implementation AFNetAPIClient
+ (AFNetAPIClient *)sharedJsonClient {
    static AFNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    
    return _sharedClient;
}
+(BOOL)netWorkReachabilityWithURLString:(NSString *) strUrl {
    __block BOOL netState = YES;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                netState = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netState = YES;
                break;
                
            default:
                break;
        }
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return netState;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    

    //返回类型默认JSON
    self.requestSerializer  = [AFHTTPRequestSerializer serializer];
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];

   
    
    //返回格式
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html", nil];
    //请求格式
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.wRequestType = Get;

    
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL)
    {
        [self setSecurityPolicy:[self customSecurityPolicy]];
    }

    
    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.requestSerializer.timeoutInterval = 10.f;
    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    return self;
}

- (AFNetAPIClient *(^)(NSString *))setRequest {
    return ^AFNetAPIClient* (NSString * url) {
        self.url = url;
        return self;
    };
}

- (AFNetAPIClient *(^)(NetworkMethod))RequestType {
    return ^AFNetAPIClient* (NetworkMethod type) {
        self.wRequestType = type;

        return self;
    };
}

- (AFNetAPIClient* (^)(id parameters))Parameters {
    return ^AFNetAPIClient* (id parameters) {
        self.parameters = parameters;
        return self;
    };
}
- (AFNetAPIClient *(^)(NSDictionary *))HTTPHeader {
    return ^AFNetAPIClient* (NSDictionary * HTTPHeaderDic) {
        self.wHTTPHeader = HTTPHeaderDic;
        return self;
    };
}
- (AFNetAPIClient* (^)(NSData * file_data))filedata {
    return ^AFNetAPIClient* (NSData * file_data) {
        self.Wyqfile_data = file_data;
        return self;
    };
}
- (AFNetAPIClient* (^)(NSString * name))name {
    return ^AFNetAPIClient* (NSString * name) {
        self.Wyqname = name;
        return self;
    };
}
- (AFNetAPIClient* (^)(NSString * filename))filename {
    return ^AFNetAPIClient* (NSString * filename) {
        self.Wyqfilename = filename;
        return self;
    };
}
- (AFNetAPIClient* (^)(NSString * mimeType))mimeType {
    return ^AFNetAPIClient* (NSString * mimeType) {
        self.WyqmimeType = mimeType;
        return self;
    };
}

- (void)startRequestWithSuccess:(WYQResponseSuccess)Success progress:(WYQProgress)Progress failure:(WYQResponseFail)Fail {

     AFNetAPIClient * manager = [[self class]sharedJsonClient];
    //设置请求头
    [self setupHTTPHeaderWithManager:manager];
   
    switch (self.wRequestType) {
        case Get: {
            [manager GET:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//                progress(downloadProgress.fractionCompleted)
                Progress(downloadProgress);//downloadProgress.fractionCompleted
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                Success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                Fail(task,error);
            }];
        }
            break;
 
        case Post: {
            
            [manager POST:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                Progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                Success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                Fail(task,error);
            }];
        }
            break;
        case Body: {
            manager.requestSerializer=[AFJSONRequestSerializer serializer];
            [manager POST:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                Progress(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                Success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                Fail(task,error);
            }];
        }
            break;

        case Put: {
            [manager PUT:self.url parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                Success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                Fail(task,error);
            }];
        }
            break;

        case Delete: {
            [manager DELETE:self.url parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                Success(task,responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               Fail(task,error);
            }];
        }
            break;

        default:
            break;
    }


}



-(NSString*)ObjectToJsonString:(id)object{
    NSString *jsonString = [[NSString
                             
                             alloc]init];
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization
                        
                        dataWithJSONObject:object
                        
                        options:NSJSONWritingPrettyPrinted
                        
                        error:&error];
    
    if (! jsonData) {
        
        NSLog(@"error: %@", error);
        
    } else {
        
        jsonString = [[NSString
                       
                       alloc] initWithData:jsonData
                      
                      encoding:NSUTF8StringEncoding];
        
    }
    
    return jsonString;
}

-(void)uploadfileWithSuccess:(WYQResponseSuccess)Success progress:(WYQProgress)Progress failure:(WYQResponseFail)Fail {
    AFNetAPIClient * manager = [[self class]sharedJsonClient];
    self.parameters=nil;
    [manager POST:self.url parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSURL *fileUrl=[NSURL fileURLWithPath:self.Wyqfilename];
        if(!fileUrl){
            return ;
        }
        
       [formData appendPartWithFileURL:fileUrl name:@"file" fileName:self.Wyqfilename mimeType:self.WyqmimeType error:nil];
//        
//        [formData appendPartWithFileData:self.Wyqfile_data name:self.Wyqname fileName:self.Wyqfilename mimeType:self.WyqmimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        Progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Fail(task,error);
    }];
}

-(NSURLSessionDownloadTask *)downloadWithSuccess:(WYQFileSuccess)WSuccess progress:(WYQProgress)Progress failure:(WYQResponseFail)Fail {
    AFNetAPIClient * manager = [[self class]sharedJsonClient];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        Progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //保存文件url (可自己改)
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSURL *fileUrl = [NSURL fileURLWithPath:cachesPath];

        return [fileUrl URLByAppendingPathComponent:[response suggestedFilename]];

    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            Fail(nil,error);
        }
        else{
            WSuccess(response,filePath);
        }
    }];
    [downloadtask resume];
    return  downloadtask;
}

- (AFNetAPIClient *)setupHTTPHeaderWithManager:(AFNetAPIClient *)manager {
    
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//    manager.requestSerializer  = [AFJSONRequestSerializer serializer];

    for (NSString * key in self.wHTTPHeader.allKeys) {

        [manager.requestSerializer setValue:self.wHTTPHeader[key] forHTTPHeaderField:key];
           }
    return manager;
}

- (void)cancelAllRequest {

    [self.operationQueue cancelAllOperations];
}

#pragma mark - https认证
- (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"srca" ofType:@"cer"]; //证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];

    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;

    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    NSSet * set = [NSSet setWithObject:certData];
    securityPolicy.pinnedCertificates = set;

    return securityPolicy;
}

@end
