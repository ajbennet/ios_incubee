//
//  PPDateManager.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 06/07/15.
//  Copyright (c) 2015 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPDateManager : NSObject
{
    NSMutableDictionary *dateFormatterDictionary;
}

+(PPDateManager*)sharedInstance;

-(NSString*)convertDateToString:(NSDate*)inDate withDateFormatterStyle:(NSString*)inDateFormatterStyle andOffset:(float)inOffsetValue;

-(NSDate*)convertStringToDate:(NSString*)inDateString withDateFormatterStyle:(NSString*)inDateFormatterStyle andWithOffset:(float)inOffsetValue;

-(NSDate*)getDate:(NSDate*)inDate withDateFormatterStyle:(NSString*)inDateFormatterStyle andWithOffset:(float)inOffsetValue;

-(NSString*)getDateString:(NSString*)inDateString withDateFormatterStyle:(NSString*)inDateFormatterStyle andOffset:(float)inOffsetValue;

-(void)recivedMemoryWarning;

@end
