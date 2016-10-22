
#import "PlaceMark.h"

@implementation PlaceMark

@synthesize coordinate = mCoordinate;
@synthesize tag;
@synthesize line1;
@synthesize line2;
@synthesize line3;
@synthesize image;
@synthesize strThumbUrl;
@synthesize index;
//@synthesize item;

- (NSString *)subtitle
{
	return @" ";
}

- (NSString *)title
{
	return @" ";
}

- (id) init
{
	line1 = @"";
	line2 = @"";
	line3 = @"";
    strThumbUrl = @"";
	return self;
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
	mCoordinate = coordinate;
	
	[self init];
	
	return self;
}

- (void) dealloc
{
	[line1 release];
	[line2 release];
	[line3 release];
	[image release];
    [strThumbUrl release];
//	[item release];
	[super dealloc];
}

@end