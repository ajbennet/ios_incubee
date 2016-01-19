//
//  ICUtilityManager.m
//  Incubee
//
//  Created by Rithesh Rao on 11/07/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICUtilityManager.h"

@implementation ICUtilityManager

static ICUtilityManager *sharedUtilityInstance = nil;

+(ICUtilityManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedUtilityInstance = [[self alloc] init];
        
    });
    
    return sharedUtilityInstance;
}
- (id)init {
    
    if (self = [super init])
    {
        
    }
    
    return self;
}

-(UIColor*)getColorFromRGB:(NSString*)inColorCode{
    
    if(inColorCode){
        const char *cStr = [inColorCode cStringUsingEncoding:NSASCIIStringEncoding];
        
        long x = strtol(cStr+1, NULL, 16);
        
        unsigned char r, g, b;
        b = x & 0xFF;
        g = (x >> 8) & 0xFF;
        r = (x >> 16) & 0xFF;
        
        return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
        
    }
    return [UIColor blackColor];
}

-(BOOL)isValidEmail:(NSString*)inEmailId{
    //No @ symbol
    NSArray *n1 = [inEmailId componentsSeparatedByString: @"@"];
    if ([n1 count] != 2)
    {
        return FALSE;
    }
    //First letter is @
    if ([[inEmailId substringToIndex:1] isEqualToString:@"@"])
    {
        return FALSE;
    }
    // last letter is @
    if ([[inEmailId substringFromIndex:[inEmailId length] -1] isEqualToString:@"@"])
    {
        return FALSE;
    }
    //No dot symbol
    n1 = [inEmailId componentsSeparatedByString: @"."];
    if ([n1 count] <= 1)
    {
        return FALSE;
    }
    //First letter is dot
    if ([[inEmailId substringToIndex:1] isEqualToString:@"."])
    {
        return FALSE;
    }
    // last letter is dot
    if ([[inEmailId substringFromIndex:[inEmailId length] -1] isEqualToString:@"."])
    {
        return FALSE;
    }
    //Check for spaces
    int len1 = (int)[inEmailId length];
    for (int i = 0; i < len1; i++)
    {
        char a = toupper([inEmailId characterAtIndex:i]);
        if (isspace(a))
        {
            return FALSE;
        }
    }
    //Check after @ is there dot before and after
    n1 = [inEmailId componentsSeparatedByString: @"@"];
    NSString *after = [n1 objectAtIndex:1];
    if ([[after substringToIndex:1] isEqualToString:@"."])
    {		
        return FALSE;
    }
    
    return TRUE;
}

@end


@implementation ICImageView


@end
