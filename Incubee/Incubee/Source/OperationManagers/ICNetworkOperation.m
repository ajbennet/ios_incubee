//
//  PPNetworkOperation.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 23/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICNetworkOperation.h"

@implementation ICNetworkOperation

-(id)initWithRequest:(ICRequest*)inRequest{
    
    self = [super init];
    
    if(self != nil)
    {
        _request = inRequest;
    }

    return self;
}


- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    
    for (NSString *key in [dictionary allKeys]) {
        
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    
    NSLog(@"Print Operation : %@",encodedDictionary);
    
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}


- (NSString*)encodeDictionaryToString:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return encodedDictionary;
}

-(void)main{

    [super main];
    
    _request.requestStatus.status = REQUEST_ON_NETWORKING;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_request.requestingURL];
    
    NSHTTPURLResponse *response = nil;
    
    if(_request.reqDataDict.allKeys.count>0)
    {
    
        [request setHTTPMethod:@"POST"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        NSError *parsingError = nil;
        
        NSData *reqData = [NSJSONSerialization dataWithJSONObject:_request.reqDataDict options:NSJSONWritingPrettyPrinted error:&parsingError];
        
        if(parsingError==nil)
        {
            [request setHTTPBody:reqData];
        }
        
        [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[reqData length]] forHTTPHeaderField:@"Content-Length"];

        
        
        NSLog(@"********** RequestData ********** \n %@",_request.reqDataDict);
    }
    
    NSError *error = nil;

    
    _request.responseRecivedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(error)
    {
        self.request.error = error;
        
        self.request.parsedResponse = (id)[[NSDictionary alloc] initWithObjectsAndKeys:error.localizedDescription,@"Error",nil];
        
        self.request.requestStatus.status = REQUEST_FINISHED;

    }
    else if(_request.responseRecivedData != nil)
    {
        NSLog(@"Networking Operartions : Is%@ main thread", ([NSThread isMainThread] ?@"" : @" NOT"));
        
        NSString *encodedStr = [[NSString alloc] initWithBytes:[_request.responseRecivedData bytes] length:_request.responseRecivedData.length encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response : %@",encodedStr);
        
        if(encodedStr==nil)
        {
            NSDictionary* details = [[NSDictionary alloc] initWithObjectsAndKeys:@"NSUTF8StringEncoding Error",NSLocalizedDescriptionKey,nil];
            
            _request.error = [NSError errorWithDomain:@"Incubee" code:200 userInfo:details];
            
            _request.requestStatus.status = REQUEST_FINISHED;
        }
        else
        {
            _request.requestStatus.status = REQUEST_ON_DATAPARSING;
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
