//
//  NSDictionary+DVATableViewModelProtocol.m
//
//  Created by Prabhu Chandrasekaran 15/03/2016.
//

#import "NSDictionary+DVATableViewModelProtocol.h"

@implementation NSDictionary (DVATableViewModelProtocol)

-(NSString *)dva_cellIdentifier {
    return [self objectForKey:@"dva_cellIdentifier"];
}

@end
