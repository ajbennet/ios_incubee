//
//  ICImageManager.h
//  Incubee
//
//  Created by Rithesh Rao on 28/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ICImageManagerDelegate <NSObject>

@required

-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString*)inUrl;

@end

@interface ICImageManager : NSObject<NSURLSessionDelegate>

@property(nonatomic,strong)NSString *imageURL;

@property(nonatomic,assign)id<ICImageManagerDelegate> delegate;

-(void)getImage:(NSString*)inUrl withDelegate:(id)inDelegate;

@end


@interface ICImageStore : NSObject

@property(nonatomic,strong)NSCache *imageCache;

+(ICImageStore*)sharedInstance;

-(UIImage*)getImageForURL:(NSString*)inURLString;

-(BOOL)isImageAvailable:(NSString*)aUrl;

-(NSData*)getImage:(NSString*)aUrl;

-(void)setData:(NSData*)imageData withKey:(NSString*)aUrl;

@end
