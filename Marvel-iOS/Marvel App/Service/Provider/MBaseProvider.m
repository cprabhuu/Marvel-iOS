//
//  MGeneralProvider.m
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//

#import "MBaseProvider.h"

@implementation MBaseProvider

- (instancetype)init {
    self = [super init];
    if (self) {
        _requestManager = [MRequestManager shared];
    }
    return self;
}

- (NSDictionary *)resultWithJson:(NSDictionary *)json key:(NSString *)key {
    return json[key];
}

- (NSArray *)resultArrayWithJson:(NSDictionary *)json key:(NSString *)key {
    return json[key];
}

@end
