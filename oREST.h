//
//  oREST.h
//  oREST
//
//  Created by bbrodriges on 11/11/13.
//

#import <Foundation/Foundation.h>

@interface oREST : NSObject

@property (nonatomic, strong) NSDictionary *requestResult;

- (void)GET:(NSString *)url;
- (void)POST:(NSString *)url;
- (void)POST:(NSString *)url params:(NSString *)params;
- (void)PUT:(NSString *)params;
- (void)DELETE:(NSString *)params;

@end
