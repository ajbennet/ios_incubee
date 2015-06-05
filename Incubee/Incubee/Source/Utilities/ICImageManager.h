//
//  PPImageManager.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 02/06/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICImageManager : NSObject{
    
}

@property(nonatomic,strong)NSCache *imageCache;

+(ICImageManager*)sharedInstance;

-(NSData*)getImage:(NSString*)aUrl;

-(void)setData:(NSData*)imageData withKey:(NSString*)aUrl;

-(BOOL)isImageAvailable:(NSString*)aUrl;

@end
