//
//  MCharactersProvider.h
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//

#import "MBaseProvider.h"

@interface MCharactersProvider : MBaseProvider

- (void)charactersProviderGetAllCharactersWithLimit:(NSInteger)limit offset:(NSInteger)offset onCompletion:(DRBaseProviderCompletion)completionBlock;

- (void)charactersProviderCharacterWithName:(NSString *)name limit:(NSInteger)limit offset:(NSInteger)offset onCompletion:(DRBaseProviderCompletion)completionBlock;

@end
