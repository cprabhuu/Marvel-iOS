//
//  MCharactersrovider.m
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//

#import "MCharactersProvider.h"

//__ Add bridge comunication with swift
#import "Marvel_App-Swift.h"

@implementation MCharactersProvider

- (void)charactersProviderGetAllCharactersWithLimit:(NSInteger)limit offset:(NSInteger)offset onCompletion:(DRBaseProviderCompletion)completionBlock {
    [self.requestManager requestManagerAllCharactersWithLimit:limit offset:offset oncompletion:^(NSURL *redirectURL, NSDictionary *json, BOOL success, NSError *error) {
        if (success) {
            NSDictionary *data = [self resultWithJson:json key:kTagMarvelData];
            NSArray *results = data[kTagMarvelResults];
            NSNumber *total = data[kTagMarvelTotal];
            NSMutableArray *characters = [NSMutableArray new];
            
            for (NSDictionary *eachCharacter in results) {
                NSString *characterName = eachCharacter[kTagMarvelName];
                NSNumber *characterId = eachCharacter[kTagMarvelId];
                NSDictionary *thumbnail = eachCharacter[kTagMarvelThumbnail];
                NSString *path = thumbnail[kTagMarvelPath];
                NSString *extension = thumbnail[kTagMarvelExtension];
                NSString *characterDescription = eachCharacter[kTagMarvelDescription];
                
                [characters addObject:[[MCharacter alloc]initWithCharacterName:characterName characterUrlImage:path characterUrlImageExtension:extension characterDescription:characterDescription characterId:characterId.integerValue]];
            }
            
            if (completionBlock) completionBlock ([characters copy], total.integerValue, nil, DRErrorEverythingOKCode, nil);
        }
        else {
            if (completionBlock) completionBlock (nil, 0, kServerErrorMessageUserFriendly, DRErrorCodeServerError, kServerErrorMessage);
        }
    }];
}

- (void)charactersProviderCharacterWithName:(NSString *)name limit:(NSInteger)limit offset:(NSInteger)offset onCompletion:(DRBaseProviderCompletion)completionBlock {
    [self.requestManager requestManagerCharacterWithName:name limit:limit offset:offset oncompletion:^(NSURL *redirectURL, NSDictionary *json, BOOL success, NSError *error) {
        if (success) {
            NSDictionary *data = [self resultWithJson:json key:kTagMarvelData];
            NSArray *results = data[kTagMarvelResults];
            NSNumber *total = data[kTagMarvelTotal];
            NSMutableArray *characters = [NSMutableArray new];
            
            for (NSDictionary *eachCharacter in results) {
                NSString *characterName = eachCharacter[kTagMarvelName];
                NSNumber *characterId = eachCharacter[kTagMarvelId];
                NSDictionary *thumbnail = eachCharacter[kTagMarvelThumbnail];
                NSString *path = thumbnail[kTagMarvelPath];
                NSString *extension = thumbnail[kTagMarvelExtension];
                NSString *characterDescription = eachCharacter[kTagMarvelDescription];
                
                [characters addObject:[[MCharacter alloc]initWithCharacterName:characterName characterUrlImage:path characterUrlImageExtension:extension characterDescription:characterDescription characterId:characterId.integerValue]];
            }
            
            if (completionBlock) completionBlock ([characters copy], total.integerValue, nil, DRErrorEverythingOKCode, nil);
        }
        else {
            if (completionBlock) completionBlock (nil, 0, kServerErrorMessageUserFriendly, DRErrorCodeServerError, kServerErrorMessage);
        }
    }];
}

@end
