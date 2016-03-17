//
//  MComicProvider.h
//  Marvel App
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//

#import "MBaseProvider.h"

@interface MComicProvider : MBaseProvider

- (void)comicProviderGetAllComicsForCharacterId:(NSInteger)characterId limit:(NSInteger)limit offset:(NSInteger)offset onCompletion:(DRBaseProviderCompletion)completionBlock;

@end
