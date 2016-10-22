//
//  SharedManager.m
//  WutzWhat
//
//  Created by Zeeshan on 15/11/2012.
//
//

#import "SharedManager.h"

#define NORMAL_FONT_SIZE    22
#define	EMPTY_STRING							@""
static SharedManager *sharedInstance = nil;

@implementation SharedManager

@synthesize currentlyViewingModuleName;
@synthesize facebookAuthenticationUsername=_facebookAuthenticationUsername;
@synthesize twitterAuthenticationUsername=_twitterAuthenticationUsername;
@synthesize numberOfRequestInQueue;
@synthesize sessionDictionay=_sessionDictionay;
@synthesize serverCall = _serverCall;
@synthesize arrChatReq;
@synthesize userSetting = _userSetting;
@synthesize dictCards;

- (id) init
{
    self = [super init];
    if (self) {
        numberOfRequestInQueue = 0;
        self.serverCall = [[ServerCall alloc] init];
        self.sessionDictionay = [[NSDictionary alloc] init];
        self.userSetting = [[NSDictionary alloc] init];
        self.arrChatReq = [[NSMutableArray alloc] init];
        self.dictCards = [[NSDictionary alloc] init];
    }
    return self;
}
+ (id)sharedManager
{
	@synchronized(self)
	{
		if (sharedInstance == nil) {
			sharedInstance = [[SharedManager alloc] init];
        }
	}
	return sharedInstance;
}

- (ServerCall*) ServerCallInstance {

    return self.serverCall;
}

-(void)saveFacebookUsernameToDisk
{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]  init];
    [dictionary setObject:self.facebookAuthenticationUsername forKey:@"Facebookuser"];
    NSError  *error;
    NSData* archiveData = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDir stringByAppendingPathComponent:@"Facebookuser.plist"];
    [archiveData writeToFile:fullPath options:NSDataWritingAtomic error:&error];
}


-(void)loadFacebookUsernameToDisk
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDir stringByAppendingPathComponent:@"Facebookuser.plist"];
    NSMutableDictionary *dict = nil;
    @try
    {
        NSData *archiveData = [NSData dataWithContentsOfFile:fullPath];
        dict = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
        
        if ([dict count] > 0) {
            
            // NSLog(@"dictCount=%d",[dict count]);
            _facebookAuthenticationUsername=[dict valueForKey:@"Facebookuser"];
        }
        
        
    }
    @catch (NSException * e)
    {
        //NSLog(@"exception in opening file");
        
    }
    @finally
    {
        
    }
    
}

-(void) saveCards {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"SavedCards:%@", self.dictCards);
    
    [standardUserDefaults setObject:self.dictCards forKey:@"Cards"];
    [standardUserDefaults synchronize];
}

-(void) loadCards {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	self.dictCards = (NSDictionary*) [standardUserDefaults objectForKey:@"Cards"];
}

-(void) saveUserSetting {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"SavedSession:%@", self.sessionDictionay);
    
    [standardUserDefaults setObject:self.userSetting forKey:@"UserSetting"];
    [standardUserDefaults synchronize];
}

-(void) loadUserSetting {
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	self.userSetting = (NSDictionary*) [standardUserDefaults objectForKey:@"UserSetting"];
}

-(void)saveSessionToDisk
{
//    NSError  *error;
//    NSData* archiveData = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
//    NSString *fullPath = [documentsDir stringByAppendingPathComponent:@"SavedSession.plist"];
//    [archiveData writeToFile:fullPath options:NSDataWritingAtomic error:&error];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    NSLog(@"SavedSession:%@", self.sessionDictionay);

    [standardUserDefaults setObject:self.sessionDictionay forKey:@"SavedSession"];
    [standardUserDefaults synchronize];
}
-(void)loadSessionFromDisk
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
//    NSString *documentsDir = [paths objectAtIndex:0];
//    NSString *fullPath = [documentsDir stringByAppendingPathComponent:@"SavedSession.plist"];
//    NSMutableDictionary *dict = nil;
//    @try
//    {
//        NSData *archiveData = [NSData dataWithContentsOfFile:fullPath];
//        dict = (NSMutableDictionary*)[NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
//        if ([dict count] > 0) {
//            self.sessionDictionay=dict;
//        }  
//    }
//    @catch (NSException * e)
//    {
//    }
//    @finally
//    {    
//    }
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	self.sessionDictionay = (NSDictionary*) [standardUserDefaults objectForKey:@"SavedSession"];
}



- (void) initializeTineView {
    tintView = [[UIAlertView alloc] initWithTitle:@"" message:@"Loading please wait..." delegate:self cancelButtonTitle:@"" otherButtonTitles:nil, nil];
    
}

- (void) showTintView {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    //[[[[UIApplication sharedApplication] delegate] window] addSubview:tintView];
    
    [tintView setCenter:CGPointMake(window.center.x, window.center.y)];
    [tintView show];
    
}
- (void) hideTintView {
    [tintView removeFromSuperview];
}
- (BOOL) isNetworkAvailable {
	
	//return YES;
	if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable && [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == NotReachable) {
		return NO;
	}
	
	else {
		return YES;
	}
}



#pragma mark -
#pragma mark NSDate
#pragma mark -

+ (NSString*) getStringFromDate:(NSDate*)aDate inFormat:(NSString*)aFormat
{
	NSString *retVal = nil;
	
	if (aFormat!=nil && [aFormat length] > 0)
    {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:aFormat];
		retVal = [formatter stringFromDate:aDate];
    }
	
	return retVal;
}

/**
 Returns NSDate* from string in the specified format
 */
+ (NSDate*) getDateFromString:(NSString*)aString withFormat:(NSString*)aFormat
{
	NSDate *retVal = nil;
	if (aFormat!=nil && [aFormat length] > 0)
    {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:aFormat];
		retVal = [formatter dateFromString:aString];
    }
	
	return retVal;
}

+(NSString*)getStringFromDifferentDateFormat:(NSString*)dateString format:(NSString*)dateFormat
{
    NSString *stringF = @"";
    NSDate *date = [self getDateFromString:dateString withFormat:@"dd-MMM-yyyy"];
    stringF  = [self getStringFromDate:date inFormat:dateFormat];
    return stringF;
}
/**
 Returns NSString* from string in the specified format
 */
+ (NSString*) getFormattedStringDateFromString:(NSString*)aString withFormat:(NSString*)aFormat
{
	NSString *retVal = nil;
	if (aFormat!=nil && [aFormat length] > 0)
    {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:aFormat];
		NSDate *dateFromString = [formatter dateFromString:aString];
		retVal = [formatter stringFromDate: dateFromString];
    }
	
	return retVal;
}
@end
