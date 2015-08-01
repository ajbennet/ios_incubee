//
//  ICUtilityManager.h
//  Incubee
//
//  Created by Rithesh Rao on 11/07/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ICUtilityManager : NSObject

+(ICUtilityManager*)sharedInstance;

-(UIColor*)getColorFromRGB:(NSString*)inColorCode;

@end

@interface ICImageView : UIImageView

@property(nonatomic,strong)NSString *imageUrl;

@end