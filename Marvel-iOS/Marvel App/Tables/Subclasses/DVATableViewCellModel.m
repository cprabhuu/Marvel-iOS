//
//  DVATableViewCellModel.m
//
//  Created by Prabhu Chandrasekaran 15/03/2016.
//

#import "DVATableViewCellModel.h"

@implementation DVATableViewCellModel

-(NSString*)description {
    return [NSString stringWithFormat:@"%@: identifier: %@, CELL: %@",[self.class description],self.cellIdentifier,self];
}

@end
