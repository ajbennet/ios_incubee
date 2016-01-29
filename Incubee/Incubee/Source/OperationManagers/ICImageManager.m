//
//  ICImageManager.m
//  Incubee
//
//  Created by Rithesh Rao on 28/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICImageManager.h"

@implementation ICImageManager

-(id)init
{
    self = [super init];
    
    return self;

}

-(void)getImage:(NSString*)inUrl withDelegate:(id)inDelegate{
    
    _delegate = inDelegate;

    _imageURL = inUrl;
    
    if([[ICImageStore sharedInstance] isImageAvailable:inUrl])
    {
        [_delegate imageDataRecived:[[ICImageStore sharedInstance] getImage:inUrl] ofURL:inUrl];
    }
    else
    {
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig
                                      delegate:self
                                 delegateQueue:nil];
        // 1
        NSURLSessionDownloadTask *getImageTask = [session
                                                  downloadTaskWithURL:[NSURL URLWithString:_imageURL]
                                                  completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error)
                                              {
                                                  if(error==nil)
                                                  {
                                                      [[ICImageStore sharedInstance] setData:[NSData dataWithContentsOfURL:location] withKey:_imageURL];
                                                      
                                                      if(_delegate && [_delegate respondsToSelector:@selector(imageDataRecived:ofURL:)])
                                                      {
                                                          [_delegate imageDataRecived:[NSData dataWithContentsOfURL:location] ofURL:inUrl];
                                                      }
                                                      
                                                      [session finishTasksAndInvalidate];
                                                  }

                                              }];
        [getImageTask resume];
    }
}

@end


@implementation ICImageStore

static ICImageStore *sharedImageStoreInstance = nil;

+(ICImageStore*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedImageStoreInstance = [[self alloc] init];
        
    });
    
    return sharedImageStoreInstance;
}
- (id)init {
    
    if (self = [super init])
    {
        
        _imageCache = [[NSCache alloc] init];
        
        [_imageCache setCountLimit:100];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/ImageCache"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        {
            NSError *error;
            
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
            
            NSURL *finalURL = [NSURL fileURLWithPath:dataPath];
            
            [self addSkipBackupAttributeToItemAtURL:finalURL];
            
        }
        
    }
    
    return self;
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                    
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    
    if(!success)
    {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    else
    {
        NSLog(@"Excluding %@ from backup ", [URL lastPathComponent]);
    }
    
    return success;
}

-(UIImage*)getImageForURL:(NSString*)inURLString{

    if([self isImageAvailable:inURLString])
    {
        return [UIImage imageWithData:[self getImage:inURLString]];
    }
    else
    {
    
    }
    return nil;

}

-(void)setData:(NSData*)imageData withKey:(NSString*)aUrl
{
    
    @synchronized(self){
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString* newString = [aUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    newString = [newString stringByReplacingOccurrencesOfString:@":" withString:@"@"];
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageCache/%@",newString]];
    
    
    [imageData writeToFile:dataPath atomically:YES]; //Write the file
    
    
    }
    
    //    [self.imageCache setObject:imageData forKey:aUrl];
    
}

-(BOOL)isImageAvailable:(NSString*)aUrl{
    
    @synchronized(self){

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString* newString = [aUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    newString = [newString stringByReplacingOccurrencesOfString:@":" withString:@"@"];
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageCache/%@",newString]];
    
    NSData *pngData  = [NSData dataWithContentsOfFile:dataPath];
    
    return pngData ? YES : NO;
    }
}

-(NSData*)getImage:(NSString*)aUrl
{
    
    @synchronized(self){

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString* newString = [aUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    newString = [newString stringByReplacingOccurrencesOfString:@":" withString:@"@"];
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageCache/%@",newString]];
    
    NSData *pngData  = [NSData dataWithContentsOfFile:dataPath];
    
    return pngData;
    }
}



@end
