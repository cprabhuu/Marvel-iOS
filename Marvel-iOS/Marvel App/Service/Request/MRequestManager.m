//
//  MRequestManager.m
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//

#import "MRequestManager.h"

#import <CommonCrypto/CommonDigest.h>

//__ Pods
#import "AFNetworkActivityIndicatorManager.h"

@implementation MRequestManager

+ (instancetype)shared {
    static MRequestManager *requestManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // will handle status bar activity indicator for us everytime
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        // setting up AFHTTPSessionManager
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        // Changed timeout interval for the requests
        sessionConfiguration.timeoutIntervalForRequest=30;
        requestManager = [[MRequestManager alloc] initWithSessionConfiguration:sessionConfiguration];
        
        requestManager.securityPolicy.allowInvalidCertificates = YES;
        requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
                
        // start notifications for reachability
        [requestManager.reachabilityManager startMonitoring];
        
        // Observe notifications for UIApplicationWillResignActiveNotification lifetime
        [[NSNotificationCenter defaultCenter] addObserver:requestManager selector:@selector(receivedNotification:) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
    });
    
    return requestManager;
}

#pragma mark - Lifetime notification

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receivedNotification:(NSNotification*)notification{
    if ([notification.name isEqualToString:UIApplicationWillResignActiveNotification]) {
        [[self tasks] enumerateObjectsUsingBlock:^(NSURLSessionTask*task, NSUInteger idx, BOOL *stop) {
            [task cancel];
        }];
    }
}

#pragma mark - Functions

+ (BOOL)recheable {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (NSURL *)responseURL:(NSURLSessionDataTask *)task {
    return task.response.URL;
}

#pragma mark - All Characters

//__ Generate MD5 value from input
- (NSString *)md5:(NSString *)input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, ((CC_LONG)strlen(cStr)), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
    
}

//__ Request all characters
- (void)requestManagerAllCharactersWithLimit:(NSInteger)limit offset:(NSInteger)offset oncompletion:(DRNetworkGeneralCompletionBlock)completionBlock {
    NSTimeInterval today = [[NSDate date] timeIntervalSince1970];
    NSString *ts = [NSString stringWithFormat:@"%f", today];
    
    NSString *hash = [NSString stringWithFormat:@"%@%@%@", ts, kMarvelPrivateKey, kMarvelPublicKey];
    
    NSDictionary *parameters = @{kTagMarvelApikey : kMarvelPublicKey,
                                 kTagMarvelTs     : ts,
                                 kTagMarvelHash   : [self md5:hash],
                                 kTagMarvelLimit  : @(limit),
                                 kTagMarvelOffSet : @(offset)
                                 };
    
    [self GET:kTagMarvelCharactersURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock) completionBlock ([self responseURL:task], responseObject, YES, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil, nil, NO, error);
    }];
}

//__ Get the character info
- (void)requestManagerCharacterWithName:(NSString *)name limit:(NSInteger)limit offset:(NSInteger)offset oncompletion:(DRNetworkGeneralCompletionBlock)completionBlock {
    NSTimeInterval today = [[NSDate date] timeIntervalSince1970];
    NSString *ts = [NSString stringWithFormat:@"%f", today];
    
    NSString *hash = [NSString stringWithFormat:@"%@%@%@", ts, kMarvelPrivateKey, kMarvelPublicKey];
    
    NSDictionary *parameters = @{kTagMarvelApikey           : kMarvelPublicKey,
                                 kTagMarvelTs               : ts,
                                 kTagMarvelHash             : [self md5:hash],
                                 kTagMarvelLimit            : @(limit),
                                 kTagMarvelOffSet           : @(offset),
                                 kTagMarvelNameStartsWith   : name
                                 };
    
    [self GET:kTagMarvelCharactersURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock) completionBlock ([self responseURL:task], responseObject, YES, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil, nil, NO, error);
    }];
}

#pragma mark - Comics

//__ Get all comics
- (void)requestManagerAllComicsForCharacterId:(NSInteger)characterId limit:(NSInteger)limit offset:(NSInteger)offset oncompletion:(DRNetworkGeneralCompletionBlock)completionBlock {
    NSTimeInterval today = [[NSDate date] timeIntervalSince1970];
    NSString *ts = [NSString stringWithFormat:@"%f", today];
    
    NSString *hash = [NSString stringWithFormat:@"%@%@%@", ts, kMarvelPrivateKey, kMarvelPublicKey];
    
    NSDictionary *parameters = @{kTagMarvelApikey      : kMarvelPublicKey,
                                 kTagMarvelTs          : ts,
                                 kTagMarvelHash        : [self md5:hash],
                                 kTagMarvelLimit       : @(limit),
                                 kTagMarvelOffSet      : @(offset)
                                 };
    NSString *comicURL = [NSString stringWithFormat:kTagMarvelComicsURL, @(characterId)];
    
    [self GET:comicURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completionBlock) completionBlock ([self responseURL:task], responseObject, YES, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock(nil, nil, NO, error);
    }];
}

@end
