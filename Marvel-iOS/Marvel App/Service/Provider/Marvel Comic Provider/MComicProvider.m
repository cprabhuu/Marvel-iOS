//
//  MComicProvider.m
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//

#import "MComicProvider.h"

//__ Add bridge comunication with swift
#import "Marvel_App-Swift.h"

@implementation MComicProvider

- (void)comicProviderGetAllComicsForCharacterId:(NSInteger)characterId limit:(NSInteger)limit offset:(NSInteger)offset onCompletion:(DRBaseProviderCompletion)completionBlock {
    [self.requestManager requestManagerAllComicsForCharacterId:characterId limit:limit offset:offset oncompletion:^(NSURL *redirectURL, NSDictionary *json, BOOL success, NSError *error) {
        if (success) {
            NSDictionary *data = [self resultWithJson:json key:kTagMarvelData];
            NSArray *results = data[kTagMarvelResults];
            NSNumber *total = data[kTagMarvelTotal];
            NSMutableArray *comics = [NSMutableArray new];
            
            for (NSDictionary *eachComic in results) {
                NSString *comicTitle = eachComic[kTagMarvelTitle];
                NSDictionary *thumbnail = eachComic[kTagMarvelThumbnail];
                NSString *path = thumbnail[kTagMarvelPath];
                NSString *extension = thumbnail[kTagMarvelExtension];
                NSString *comicDescription = nil;
                if(![eachComic[kTagMarvelDescription] isEqual:[NSNull null]]) {
                    comicDescription = eachComic[kTagMarvelDescription];
                }
                
                [comics addObject:[[MComic alloc] initWithComicTitle:comicTitle comicUrlImage:path comicUrlImageExtension:extension comicDescription:comicDescription]];
            }
            
            if (completionBlock) completionBlock ([comics copy], total.integerValue, nil, DRErrorEverythingOKCode, nil);
        }
        else {
            if (completionBlock) completionBlock (nil, 0, kServerErrorMessageUserFriendly, DRErrorCodeServerError, kServerErrorMessage);
        }
    }];
}

@end
