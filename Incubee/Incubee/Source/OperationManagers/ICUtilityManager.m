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


@end


@implementation ICImageView


@end
