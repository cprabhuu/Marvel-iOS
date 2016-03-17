//
//  NSDictionary+DVAPlistModelDatasource.m
//
//  Created by Prabhu Chandrasekaran 15/03/2016.
//

#import "NSDictionary+DVAPlistModelDatasource.h"

@implementation NSDictionary (DVAPlistModelDatasource)
-(instancetype)initWithPlist:(NSString*)plist {
    if ([self init] != nil) {
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
        self = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }
    return self;
}

@end
