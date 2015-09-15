

//
//  PPNetworkOperation.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 23/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICNetworkOperation.h"
#import "ICDataManager.h"


@implementation ICNetworkOperation

-(id)initWithRequest:(ICRequest*)inRequest{
    
    self = [super init];
    
    if(self != nil)
    {
        _requestObject = inRequest;
    }

    return self;
}

-(void)main{

    [super main];
    
    _requestObject.requestStatus.status = REQUEST_ON_NETWORKING;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_requestObject.requestingURL];
    
    NSHTTPURLResponse *response = nil;
    
    // Configuring Header data.
    
    if(_requestObject.requestMethod.length!=0)
    {
        [request setHTTPMethod:_requestObject.requestMethod];
    }
    
        [request setValue:@"Accept" forHTTPHeaderField:@"Content-Type"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        if(_requestObject.isTokenRequired)
        {
            [request setValue:[[ICDataManager sharedInstance] getToken] forHTTPHeaderField:@"token"];
        }
    
    NSLog(@"********** RequestURL ********** %d *** :  URL : %@",_requestObject.requestId,_requestObject.requestingURL);

    if(_requestObject.reqDataDict.allKeys.count>0)
    {
        NSError *parsingError = nil;
        
        NSData *reqData = [NSJSONSerialization dataWithJSONObject:_requestObject.reqDataDict options:NSJSONWritingPrettyPrinted error:&parsingError];
        
        if(parsingError==nil)
        {
            [request setHTTPBody:reqData];
        }
        
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[reqData length]] forHTTPHeaderField:@"Content-Length"];
        
        
        NSLog(@"********** RequestData ********** %d *** \n %@",_requestObject.requestId,_requestObject.reqDataDict);
    }
    
    NSError *error = nil;

    
    _requestObject.responseRecivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error)
    {
        _requestObject.error = error;
        
        _requestObject.parsedResponse = (id)[[NSDictionary alloc] initWithObjectsAndKeys:error.localizedDescription,@"Error",nil];
        
        _requestObject.requestStatus.status = REQUEST_FINISHED;

    }
    else if(_requestObject.responseRecivedData != nil)
    {
        NSLog(@"Networking Operartions : Is%@ main thread", ([NSThread isMainThread] ?@"" : @" NOT"));
        
        NSString *encodedStr = [[NSString alloc] initWithBytes:[_requestObject.responseRecivedData bytes] length:_requestObject.responseRecivedData.length encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response : %@",encodedStr);
        
        if(encodedStr==nil)
        {
            NSDictionary* details = [[NSDictionary alloc] initWithObjectsAndKeys:@"NSUTF8StringEncoding Error",NSLocalizedDescriptionKey,nil];
            
            _requestObject.error = [NSError errorWithDomain:@"Incubee" code:200 userInfo:details];
            
            _requestObject.requestStatus.status = REQUEST_FINISHED;
        }
        else
        {
            _requestObject.requestStatus.status = REQUEST_ON_DATAPARSING;
        }
    }
    else
    {
        NSLog(@"NO DATA");

        NSLog(@"Is%@ main thread", ([NSThread isMainThread] ? @"" : @" NOT"));
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    receivedData = [[NSMutableData alloc] init];
    
    [receivedData setLength:0];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [receivedData appendData:data];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"Is%@ main thread", ([NSThread isMainThread] ? @"" : @" NOT"));

    NSLog(@"Succeeded! Received %d bytes of data", (int)[receivedData length]);
    
    NSString *responeString = [[NSString alloc] initWithData:receivedData
                                                    encoding:NSUTF8StringEncoding];
    
    NSLog(@"responeString :%@",responeString);
    // Assume lowercase
    if ([responeString isEqualToString:@"true"]) {
        // Deal with true
        return;
    }
    // Deal with an error
    
    
    CFRunLoopStop(CFRunLoopGetCurrent());

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    CFRunLoopStop(CFRunLoopGetCurrent());


    
}

@end
