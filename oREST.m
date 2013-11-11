//
//  oREST.m
//  oREST
//
//  Created by bbrodriges on 11/11/13.
//

#import "oREST.h"

@interface oREST()

- (void)forwardInvocation:(NSInvocation *)inv;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;

@end

@implementation oREST

- (void)forwardInvocation:(NSInvocation *)inv {
    id __unsafe_unretained url = nil;
    id __unsafe_unretained params = nil;
    
    // getting type of given request
    NSString *requestType = NSStringFromSelector([inv selector]);
    // getting url
    [inv getArgument:&url atIndex:2];
    // creating request object
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // getting params for POST request
    if ([requestType isEqualToString:@"POST"]) {
        if ([[inv methodSignature] numberOfArguments] == 4) {
            [inv getArgument:&params atIndex:3];
        }
        // setting form encoded header
        [request setValue:@"application/x-www-form-urlencoded; charset=UTF8" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"X-Accept"];
    }
    
    [request setHTTPMethod:requestType];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSHTTPURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    
    NSString *data = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSNumber *statusCode = [NSNumber numberWithUnsignedInteger:[response statusCode]];
    _requestResult = [NSDictionary dictionaryWithObjectsAndKeys:
                            data,       @"data",
                            statusCode, @"statusCode",
                            nil];
}

// forwardInvocation: does not work without methodSignatureForSelector:
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    unsigned long numArgs = [[NSStringFromSelector(aSelector) componentsSeparatedByString:@":"] count] - 1;
    return [NSMethodSignature signatureWithObjCTypes:
            [[@"v@:" stringByPaddingToLength:numArgs+3 withString:@"@" startingAtIndex:0] UTF8String]];
}

@end
