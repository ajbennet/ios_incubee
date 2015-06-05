//
//  PPImageManager.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 02/06/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICImageManager.h"

@interface ICImageManager ()

-(BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end

@implementation ICImageManager

static ICImageManager *sharedImageManagerInstance = nil;


+(ICImageManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedImageManagerInstance = [[self alloc] init];
    });
    
    return sharedImageManagerInstance;
}

- (id)init {
    
    if (self = [super init])
    {

        self.imageCache = [[NSCache alloc] init];
        [self.imageCache setCountLimit:100];
        
        
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


-(void)setData:(NSData*)imageData withKey:(NSString*)aUrl
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString* newString = [aUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    newString = [newString stringByReplacingOccurrencesOfString:@":" withString:@"@"];

    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageCache/%@",newString]];
    

    [imageData writeToFile:dataPath atomically:YES]; //Write the file

    
    

//    [self.imageCache setObject:imageData forKey:aUrl];
    
}

-(BOOL)isImageAvailable:(NSString*)aUrl{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    
    NSString* newString = [aUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    newString = [newString stringByReplacingOccurrencesOfString:@":" withString:@"@"];
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageCache/%@",newString]];
    
    NSData *pngData  = [NSData dataWithContentsOfFile:dataPath];

    return pngData ? YES : NO;

}

-(NSData*)getImage:(NSString*)aUrl
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory

    NSString* newString = [aUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    newString = [newString stringByReplacingOccurrencesOfString:@":" withString:@"@"];
    
    NSString *dataPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/ImageCache/%@",newString]];

    NSData *pngData  = [NSData dataWithContentsOfFile:dataPath];
    
    return pngData;

}

@end
