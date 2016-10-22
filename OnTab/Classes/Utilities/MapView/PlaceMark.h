#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//#import "RSSItem.h"

@interface PlaceMark : NSObject <MKAnnotation>
{
	CLLocationCoordinate2D mCoordinate;
	NSInteger tag;
	NSString *line1;
	NSString *line2;
	NSString *line3;
	UIImage *image;
//	RSSItem *item;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, retain) NSString *line1;
@property (nonatomic, retain) NSString *line2;
@property (nonatomic, retain) NSString *line3;
@property (nonatomic, retain) NSString *strThumbUrl;
@property (nonatomic, retain) UIImage *image;
//@property (nonatomic, retain) RSSItem *item;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (NSString *) subtitle;
- (NSString *) title;

@end
