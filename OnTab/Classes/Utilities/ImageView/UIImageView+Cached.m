//  UIImageView+Cached.h
//
//  Created by Lane Roathe
//  Copyright 2009 Ideas From the Deep, llc. All rights reserved.

#import "UIImageView+Cached.h"
#import "AppDelegate.h"

#pragma mark -
#pragma mark --- Threaded & Cached image loading ---

@implementation UIImageView (Cached)

// max # of images we will cache before flushing cache and starting over
#define MAX_CACHED_IMAGES 50

// method to return a static cache reference (ie, no need for an init method)
- (NSMutableDictionary *)cache
{
	static NSMutableDictionary *_cache = nil;
	
	if( !_cache )
		_cache = [[NSMutableDictionary alloc] initWithCapacity:MAX_CACHED_IMAGES];

	assert(_cache);
	return _cache;
}

// Loads an image from a URL, caching it for later loads
// This can be called directly, or via one of the threaded accessors
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)cacheFromURL:(NSURL *)url
{
    NSLog(@"%@", url);
    @autoreleasepool {
        UIImage *newImage = [[self cache] objectForKey:url.description];
        if (!newImage) {
			NSError *err = nil;
			UIActivityIndicatorView* acitivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
            [acitivityIndicator setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
            [acitivityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [self addSubview:acitivityIndicator];
            acitivityIndicator.hidden = FALSE;
            [acitivityIndicator startAnimating];
            static int counter = 0;
            counter++;
            if (url == nil) {
//                NSLog(@"%d", counter);
//                NSLog(@"%@", url.description);
                NSLog(@"Error : url is Null");
            } else {
                
                NSData* data = [NSData dataWithContentsOfURL:url];
//                data = [NSData dataWithContentsOfURL:url options:NSData error:&err];
                if (data) {
                    newImage = [UIImage imageWithData:data];
//                    if (newImage.size.width > 320)
//                        newImage = [self imageWithImage:newImage scaledToSize:CGSizeMake(320, 320)];
                    if ( newImage ) {
                        // check to see if we should flush existing cached items before adding this new item
                        if( [[self cache] count] >= MAX_CACHED_IMAGES )
                            [[self cache] removeAllObjects];
                        
                        [[self cache] setValue:newImage forKey:url.description];
                        
                        [acitivityIndicator stopAnimating];
                        acitivityIndicator.hidden = TRUE;
                        [acitivityIndicator release];
                    }
                }
                else {
                    NSLog( @"UIImageView:LoadImage Failed: %@", err );
                    newImage = [UIImage imageNamed:@"no_image"];
                    [acitivityIndicator stopAnimating];
                    acitivityIndicator.hidden = TRUE;
                    [acitivityIndicator release];
                }
            }
            
        }
        
        
        if ( newImage ) {
            [self performSelectorOnMainThread:@selector(setImage:) withObject:newImage waitUntilDone:NO];
        }
    }
}

// Methods to load and cache an image from a URL on a separate thread
- (void)loadFromURL:(NSURL *)url
{
	[self performSelectorInBackground:@selector(cacheFromURL:) withObject:url]; 
}

-(void)loadFromURL:(NSURL *)url afterDelay:(float)delay
{
	[self performSelector:@selector(loadFromURL:) withObject:url afterDelay:delay];
}

@end
