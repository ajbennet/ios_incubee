//
//  PPDateManager.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 06/07/15.
//  Copyright (c) 2015 Deja View Concepts. All rights reserved.
//

#import "PPDateManager.h"

@implementation PPDateManager

static PPDateManager *sharedDateManagerInstance = nil;

+(PPDateManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedDateManagerInstance = [[self alloc] init];
    });
    
    return sharedDateManagerInstance;
}

- (id)init {
    
    if (self = [super init])
    {
        dateFormatterDictionary = [[NSMutableDictionary alloc] init];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recivedMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        
        return self;
    }
    
    return nil;
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(NSDateFormatter*)getDateFormatter:(NSString*)inDateFormaterType withOffset:(float)inOffsetValue{
    
    NSString *key = [NSString stringWithFormat:@"%@-%f",inDateFormaterType,inOffsetValue];
    
    NSDateFormatter *dateFormatter = (NSDateFormatter*)[dateFormatterDictionary objectForKey:key];
    
    if(dateFormatter == nil)
    {
        if(dateFormatterDictionary == nil)
        {
            dateFormatterDictionary = [[NSMutableDictionary alloc] init];
        }
        
        dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateFormat:inDateFormaterType];
        
        float offset = 3600 * inOffsetValue;
        
        if(offset==0)
        {
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        }
        else
        {
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:offset]];
        }
        
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
        [dateFormatterDictionary setObject:dateFormatter forKey:key];

    }
    
    return dateFormatter;
    
}

// Working Fine.
-(NSString*)convertDateToString:(NSDate*)inDate withDateFormatterStyle:(NSString*)inDateFormatterStyle andOffset:(float)inOffsetValue{

    NSDateFormatter *df = [self getDateFormatter:inDateFormatterStyle withOffset:inOffsetValue];
    
    NSString *outDateString = [df stringFromDate:inDate];
    
    return outDateString;
    
}

// Working Fine.
-(NSDate*)convertStringToDate:(NSString*)inDateString withDateFormatterStyle:(NSString*)inDateFormatterStyle andWithOffset:(float)inOffsetValue{
    
    NSDateFormatter *df = [self getDateFormatter:inDateFormatterStyle withOffset:inOffsetValue];
    
    NSDate *outDate = [df dateFromString:inDateString];
    
    return outDate;
    
}

// Working Fine.
-(NSDate*)getDate:(NSDate*)inDate withDateFormatterStyle:(NSString*)inDateFormatterStyle andWithOffset:(float)inOffsetValue{
    
    NSDateFormatter *df = [self getDateFormatter:inDateFormatterStyle withOffset:inOffsetValue];
    
    NSDate *outDate = [df dateFromString:[df stringFromDate:inDate]];
    
    return outDate;
}

// Working Fine.
-(NSString*)getDateString:(NSString*)inDateString withDateFormatterStyle:(NSString*)inDateFormatterStyle andOffset:(float)inOffsetValue{
    
    NSDateFormatter *df = [self getDateFormatter:inDateFormatterStyle withOffset:inOffsetValue];
    
    NSString *outDate = [df stringFromDate:[df dateFromString:inDateString]];
    
    return outDate;
    
}

-(void)recivedMemoryWarning{

    NSLog(@"%@ : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    
    dateFormatterDictionary = nil;
    
}

@end
