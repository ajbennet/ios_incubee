//
//  PPJSONParsingOperations.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 29/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICJSONParsingOperations.h"
#import "ICAppManager+Networking.h"

@implementation ICJSONParsingOperations

-(id)initWithRequest:(ICRequest*)inRequest{
    
    self = [super init];
    
    if(self != nil)
    {
        _request = inRequest ;
    }
    
    return self;
}

-(void)main{
    
    [super main];
    
    NSLog(@"Data Parsing Operartions : Is%@ main thread", ([NSThread isMainThread] ?@"" : @" NOT"));
    
    NSString *json_string = [[NSString alloc] initWithBytes:[_request.responseRecivedData bytes] length:_request.responseRecivedData.length encoding:NSUTF8StringEncoding];

    if(json_string)
    {
        NSError *error = nil;
        
        id parsedRespo = [NSJSONSerialization JSONObjectWithData:_request.responseRecivedData options:NSJSONReadingMutableLeaves error:&error];
        
        if(error == nil)
        {
            NSLog(@"JSON Parsing Succesfull : %@",json_string);

            _request.parsedResponse = parsedRespo;
            
            switch (_request.requestId) {
                case IC_GOOGLE_SIGNUP:
                case IC_LOGIN_REQUEST:
                case IC_LIKE_PROJECT:
                {
                    NSString *statusCode = [((NSDictionary*)parsedRespo) valueForKey:@"statusCode"];
                    
                    if([statusCode rangeOfString:@"1000"].location!=NSNotFound)
                    {
                        
                    }
                    else
                    {
                        NSDictionary* details = [[NSDictionary alloc] initWithObjectsAndKeys:[((NSDictionary*)parsedRespo) valueForKey:@"statusMessage"],NSLocalizedDescriptionKey,nil];
                        
                        
                        NSString *code = [statusCode substringFromIndex:[statusCode rangeOfString:@"_"].location+1];
                        _request.error = [NSError errorWithDomain:@"Incubee" code:[code integerValue] userInfo:details];
                        
                        _request.requestStatus.status = REQUEST_FINISHED;
                        
                    }
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
            _request.requestStatus.status = REQUEST_ON_DATASAVING;
            

        }
        else
        {
            NSDictionary* details = [[NSDictionary alloc] initWithObjectsAndKeys:error.localizedDescription,NSLocalizedDescriptionKey,nil];

            _request.error = [NSError errorWithDomain:@"Incubee" code:200 userInfo:details];
            
            _request.requestStatus.status = REQUEST_FINISHED;
        }
    }
    else
    {
        NSDictionary* details = [[NSDictionary alloc] initWithObjectsAndKeys:@"Json Parsing Error",NSLocalizedDescriptionKey,nil];

        _request.error = [NSError errorWithDomain:@"Incubee" code:200 userInfo:details];
        
        _request.requestStatus.status = REQUEST_FINISHED;
    }

}
@end
