//
//  MRequestManager.h
//
//  Created by Prabhu Chandrasekaran 16/03/2016.
//

@import AFNetworking;

//__ End Points
#import "MRequestEndPoints.h"

/**
 A general completion block for network calls
 
 @param redirectURL the redirect URL if any
 @param json        a json returned from server
 @param success     if success
 @param error       error object
 
 @since 1.0
 */
typedef void(^DRNetworkGeneralCompletionBlock)(NSURL *redirectURL, NSDictionary *json, BOOL success, NSError *error);

/**
 A subclass of `AFHTTPSessionManager` to perform calls and enqueue them
 
 @since 1.0
 */
@interface MRequestManager : AFHTTPSessionManager

+ (instancetype)shared;
+ (BOOL)recheable;

#pragma mark - All Characters

- (void)requestManagerAllCharactersWithLimit:(NSInteger)limit offset:(NSInteger)offset oncompletion:(DRNetworkGeneralCompletionBlock)completionBlock;

- (void)requestManagerCharacterWithName:(NSString *)name limit:(NSInteger)limit offset:(NSInteger)offset oncompletion:(DRNetworkGeneralCompletionBlock)completionBlock;

- (void)requestManagerAllComicsForCharacterId:(NSInteger)characterId limit:(NSInteger)limit offset:(NSInteger)offset oncompletion:(DRNetworkGeneralCompletionBlock)completionBlock;

@end
