//
//  MGeneralProvider.h
//
//  Created by Prabhu Chandrasekaran 14/03/2016.
//

//__ Managers
#import "MRequestManager.h"

//__ Utils
#import "MRequestEndPoints.h"


typedef NS_ENUM(NSUInteger, DRErrorCode) {
    DRErrorEverythingOKCode                =  -1,
    DRErrorGeneralCode                     =  0,
    DRErrorCodeServerError                 =  1,
};

typedef void (^DRBaseProviderCompletion)(NSArray *characters, NSInteger total, NSString *alert, DRErrorCode errorCode, NSString *errorMessage);

@interface MBaseProvider : NSObject

@property (strong, nonatomic) MRequestManager     *requestManager;

- (NSDictionary *)resultWithJson:(NSDictionary *)json key:(NSString *)key;
- (NSArray *)resultArrayWithJson:(NSDictionary *)json key:(NSString *)key;

@end
