//
//  FirstViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 23/05/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "HomeViewController.h"
#import "ICImageManager.h"

#define SWIPE_MOVE 100.0f

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intialData" ofType:@"plist"];
    
    _projectList = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    NSLog(@"%@",_projectList);
    
    [self setupDetails:_cardB withDic:[_projectList objectAtIndex:4]];
    
    [self setupDetails:_cardA withDic:[_projectList objectAtIndex:6]];
    
    _showingCard = _cardA;
    
    _cardA.layer.borderColor = _cardB.layer.borderColor = [UIColor grayColor].CGColor;
    _cardA.layer.borderWidth = _cardB.layer.borderWidth = 2.0f;
    _cardA.layer.cornerRadius = _cardB.layer.cornerRadius = 5.0f;;

    UIPanGestureRecognizer *gestureRecognizerA = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    
    UIPanGestureRecognizer *gestureRecognizerB = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    
    [_cardB addGestureRecognizer:gestureRecognizerB];
    
    [_cardA addGestureRecognizer:gestureRecognizerA];

    _originalFrame = _cardA.frame;
}

-(void)setupDetails:(UIView*)inCard withDic:(NSDictionary*)inDic{

    _selectedCard = inDic;
    
    if(inCard == _cardA)
    {
        _aTitleLab.text = [inDic valueForKey:@"ProjectName"];
        
        _aDescLab.text = [inDic valueForKey:@"ProjectTeam"];
        
        [self setupMedia:inDic forView:_cardA];
        
    }
    else if(inCard == _cardB)
    {
        _bTitleLab.text = [inDic valueForKey:@"ProjectName"];
        
        _bDescLab.text = [inDic valueForKey:@"ProjectTeam"];
        
        [self setupMedia:inDic forView:_cardB];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupMedia:(NSDictionary*)inCard forView:(UIView*)inView{

    _moviePlayer = nil;
    
    if([[inCard valueForKey:@"MediaType"] isEqualToString:@"Image"])
    {
        _aMovieView.hidden = _bMovieView.hidden = YES;
        
        _aImageView.hidden = _bImageView.hidden = NO;
        if(_cardA == inView)
        {
            
            NSData *imageData =[[ICImageManager sharedInstance] getImage:[inCard valueForKey:@"MediaURL"]];
            
             if (imageData)
            {
                _aImageView.image = [UIImage imageWithData:imageData];
            
                _aActivityIndicator.hidden = YES;
            
                [_aActivityIndicator stopAnimating];
            }
            else
            {
                 _aActivityIndicator.hidden = NO;
                 
                 [_aActivityIndicator startAnimating];

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    
                    NSString *urlString = [inCard valueForKey:@"MediaURL"];
                    
                    NSError *error = nil;
                    
                    NSData* downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingUncached error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _aActivityIndicator.hidden = YES;
                        
                        [_aActivityIndicator stopAnimating];
                        
                        if (error)
                        {
                            NSLog(@"%@", [error localizedDescription]);
                        }
                        else
                        {
                            if (downloadedData) {
                            
                                [[ICImageManager sharedInstance] setData:downloadedData withKey:urlString];
                                
                                _aImageView.image = [UIImage imageWithData:downloadedData];
                                
                            }
                        }
                        
                    });
                });
                
                
             }

            
        }
        else if(_cardB == inView)
        {
            
            NSData *imageData =[[ICImageManager sharedInstance] getImage:[inCard valueForKey:@"MediaURL"]];
            
            if (imageData)
            {
                _bImageView.image = [UIImage imageWithData:imageData];
                
                _bActivityIndicator.hidden = YES;
                
                [_bActivityIndicator stopAnimating];
            }
            else
            {
                _bActivityIndicator.hidden = NO;
                
                [_bActivityIndicator startAnimating];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    
                    NSString *urlString = [inCard valueForKey:@"MediaURL"];
                    
                    NSError *error = nil;
                    
                    NSData* downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingUncached error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _bActivityIndicator.hidden = YES;
                        
                        [_bActivityIndicator stopAnimating];
                        
                        if (error)
                        {
                            NSLog(@"%@", [error localizedDescription]);
                        }
                        else
                        {
                            if (downloadedData) {
                                
                                [[ICImageManager sharedInstance] setData:downloadedData withKey:urlString];
                                
                                _bImageView.image = [UIImage imageWithData:downloadedData];
                                
                            }
                        }
                        
                    });
                });
                
                
            }
            
            
        }
    }
//    else if([[inCard valueForKey:@"MediaType"] isEqualToString:@"Video"])
//    {
//        _aMovieView.hidden = _bMovieView.hidden = NO;
//        
//        _aImageView.hidden = _bImageView.hidden = YES;
//        
//        if(_cardA == inView)
//        {
//            
//            NSString *filePath = @"http://central.paparazzipass.com/media/CoasterCorkscrew/2015/02/16/13/3d4f14a0-9074-4eea-a31c-fc64cd9d427b.mp4";
//            
//            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:filePath]];
//            
//            [_moviePlayer.view setFrame:CGRectMake(0, 0, _aMovieView.frame.size.width, _aMovieView.frame.size.height)];
//            _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
//            _moviePlayer.shouldAutoplay=YES;
//            _moviePlayer.repeatMode = NO;
//            [_moviePlayer setFullscreen:YES animated:NO];
//            _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//            
//            [_moviePlayer prepareToPlay];
//            
//            [_aMovieView addSubview:_moviePlayer.view];
//            
//            [_moviePlayer play];
//
//        }
//        else if(_cardB == inView)
//        {
//        
//            
//            NSString *filePath = @"http://central.paparazzipass.com/media/CoasterCorkscrew/2015/02/16/13/3d4f14a0-9074-4eea-a31c-fc64cd9d427b.mp4";
//            
//            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:filePath]];
//            
//            [_moviePlayer.view setFrame:CGRectMake(0, 0, _bMovieView.frame.size.width, _bMovieView.frame.size.height)];
//            _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
//            _moviePlayer.shouldAutoplay=YES;
//            _moviePlayer.repeatMode = NO;
//            [_moviePlayer setFullscreen:YES animated:NO];
//            _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//            
//            [_moviePlayer prepareToPlay];
//            
//            [_bMovieView addSubview:_moviePlayer.view];
//            
//            [_moviePlayer play];
//
//        }
//    }
}

//-(void)setupMediaFor:(NSDictionary*)inCard{
//    
//    if([[inCard valueForKey:@"MediaType"] isEqualToString:@"Image"])
//    {
//        _mediaImageView.hidden = NO;
//        _mediaMoviePlayerView.hidden = YES;
//        {
//            
//            NSData *imageData =[[ICImageManager sharedInstance] getImage:[inCard valueForKey:@"MediaURL"]];
//            
//            if (imageData)
//            {
//                _mediaImageView.image = [UIImage imageWithData:imageData];
//                
//                _cardAactivityIndicator.hidden = YES;
//                
//                [_cardAactivityIndicator stopAnimating];
//
//            }
//            else
//            {
//                _mediaImageView.image = nil;
//                
//                _cardAactivityIndicator.hidden = NO;
//                
//                [_cardAactivityIndicator startAnimating];
//                
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//                    
//                    NSString *urlString = [inCard valueForKey:@"MediaURL"];
//                    
////                    NSData *downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
//                    
//                    NSError *error = nil;
//                    
//                    NSData* downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingUncached error:&error];
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                        _cardAactivityIndicator.hidden = YES;
//                        
//                        [_cardAactivityIndicator stopAnimating];
//
//                    if (error)
//                    {
//                        NSLog(@"%@", [error localizedDescription]);
//                    }
//                    else
//                    {
//                        if (downloadedData) {
//                            
//                            [[ICImageManager sharedInstance] setData:downloadedData withKey:urlString];
//                            
//                                _mediaImageView.image = [UIImage imageWithData:downloadedData];
//    
//                        }
//                    }
//                    
//                    });
//                });
//            }
//        }
//        
//        
//        
//    }
//    else if([[inCard valueForKey:@"MediaType"] isEqualToString:@"Video"])
//    {
//        _mediaImageView.hidden = YES;
//        
//        _mediaMoviePlayerView.hidden = NO;
//        
//        NSString *filePath = @"http://central.paparazzipass.com/media/CoasterCorkscrew/2015/02/16/13/3d4f14a0-9074-4eea-a31c-fc64cd9d427b.mp4";
//
//        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:filePath]];
//        
//        [_moviePlayer.view setFrame:CGRectMake(0, 0, _mediaMoviePlayerView.frame.size.width, _mediaMoviePlayerView.frame.size.height)];
//        _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
//        _moviePlayer.shouldAutoplay=YES;
//        _moviePlayer.repeatMode = NO;
//        [_moviePlayer setFullscreen:YES animated:NO];
//        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//        
//        [_moviePlayer prepareToPlay];
//        
//        [_mediaMoviePlayerView addSubview:_moviePlayer.view];
//        
//        [_moviePlayer play];
//
//    }
//    
//}
//

-(void)bringThisFront:(UIView*)inView{

    [self.view bringSubviewToFront:inView];
}

- (IBAction)nextCardTapped:(id)sender {
    
    int r1 = arc4random_uniform((int)(_projectList.count));

    int r2 = arc4random_uniform((int)(_projectList.count));
    
    if(_showingCard == _cardA)
    {
        [self bringThisFront:_cardB];
        
        [self setupDetails:_cardA withDic:[_projectList objectAtIndex:r1]];
        
        _showingCard = _cardB;

    }
    else if(_showingCard == _cardB)
    {
        [self bringThisFront:_cardA];

        [self setupDetails:_cardB withDic:[_projectList objectAtIndex:r2]];
        
        _showingCard = _cardA;

    }
    
}

-(void)dragging:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        _originalFrame = _showingCard.frame;

        _panCoord = [gesture locationInView:self.view];
        
        _selectedCoord = [gesture locationInView:gesture.view];
        
        
//        CGRect yFr = _yesButton.frame;
//        
//        yFr.size.width = yFr.size.width-(yFr.size.width/2);
//        
//        yFr.size.height = yFr.size.height-(yFr.size.height/2);
//        
//        _yesButton.frame = yFr;
//        
//        CGRect nFr = _noButton.frame;
//
//        nFr.size.width = nFr.size.width-(nFr.size.width/2);
//        
//        nFr.size.height = nFr.size.height-(nFr.size.height/2);
//        
//        _noButton.frame = nFr;
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint newCoord = [gesture locationInView:self.view];
        
        float dX = newCoord.x-_panCoord.x;
        
        float dY = newCoord.y-_panCoord.y;

        if(dX > SWIPE_MOVE)
        {
            [self nextCardTapped:nil];
        }
        else if( dX < (-(SWIPE_MOVE)))
        {
            [self nextCardTapped:nil];
        }
        _showingCard.frame = _originalFrame;
        
        
//        CGRect yFr = _yesButton.frame;
//        
//        yFr.size.width = yFr.size.width*(yFr.size.width);
//        
//        yFr.size.height = yFr.size.height*(yFr.size.height);
//        
//        _yesButton.frame = yFr;
//        
//        CGRect nFr = _noButton.frame;
//        
//        nFr.size.width = nFr.size.width*(nFr.size.width);
//        
//        nFr.size.height = nFr.size.height*(nFr.size.height);
//        
//        _noButton.frame = nFr;
        
        
        
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
    CGPoint newCoord = [gesture locationInView:gesture.view];
        
    float dX = newCoord.x-_panCoord.x;
        
    float dY = newCoord.y-_panCoord.y;
        
//    float ddx = newCoord.x-_selectedCoord.x;
//        
//    float ddy = newCoord.y-_selectedCoord.y;
//        
//    if(ddx>0)
//    {
//        // Movving Right;
//        NSLog(@"Movving Right : %f",dX);
//        _yesButton.alpha = ddx/SWIPE_MOVE;
//    }
//    else if(ddx<0)
//    {
//        // Movving left;
//        NSLog(@"Movving left : %f",dX);
//        _noButton.alpha = ddx/SWIPE_MOVE;
//    }
    
    _showingCard.frame = CGRectMake(_showingCard.frame.origin.x+dX, _showingCard.frame.origin.y+dY, _showingCard.frame.size.width, _showingCard.frame.size.height);
        
        
    }
    
}
@end
