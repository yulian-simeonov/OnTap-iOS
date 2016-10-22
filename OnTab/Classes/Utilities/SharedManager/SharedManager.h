//
//  SharedManager.h
//  WutzWhat
//
//  Created by Zeeshan on 15/11/2012.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "ServerCall.h"

@interface SharedManager : NSObject
{
    SharedManager *singleton;
    
    UIAlertView *tintView;
    
    NSString *currentlyViewingModuleName;
    
    
    NSString *facebookAuthenticationUsername;
    
    int numberOfRequestInQueue;
}

@property (nonatomic,readwrite) int numberOfRequestInQueue;
@property (nonatomic,retain) NSString *currentlyViewingModuleName;
@property (nonatomic,retain) NSString *facebookAuthenticationUsername;
@property (nonatomic,assign) NSString *twitterAuthenticationUsername;
@property (nonatomic,strong) NSDictionary *sessionDictionay;
@property (nonatomic,strong) NSDictionary *dictCards;
@property (nonatomic,strong) NSDictionary *userSetting;
@property (nonatomic,strong) NSMutableArray *arrChatReq;

@property (nonatomic, strong)       ServerCall                  *serverCall;

+ (id)sharedManager;

- (ServerCall*) ServerCallInstance;

- (BOOL) isNetworkAvailable ;

- (void) showTintView;
- (void) hideTintView;

#pragma mark -
#pragma mark Managers
#pragma mark -
-(void)saveSessionToDisk;
-(void)loadSessionFromDisk;

-(void) saveUserSetting;
-(void) loadUserSetting;

-(void) saveCards;
-(void) loadCards;
//+(UIFont *) helveticaNeueFont:(float) size
;

/**
 Returns bold font for application with size.
 */
//+(UIFont *) helveticaNeueBoldFont:(float) size
;

//+ (float) getHeightFromText:(NSString*)aText font:(UIFont*)font maxWidth:(float)aWidth
;

//+(CGRect)frameForHeightOfLabel:(UILabel*)lbl forText:(NSString*)text
;

//+(void)setNormalFontSizeWithDarkGrayColor:(id)control
;
//+(void)setNormalFontSizeWithDarkGrayColor:(id)control size:(NSInteger)size
;
//+(void)setNormalRedFontSize:(id)control withSize:(NSInteger)size
;
//+(void)setNormalFontSize:(id)control
;
#pragma mark -
#pragma mark Label Creation
#pragma mark -
///**
// Creates a UILabel with preset values and single line.
// */
////+(UILabel*) createFieldLabel:(CGRect) lblRect withText:(NSString *) withText
//;
//
///**
// Creates a UILabel with preset values and multiple lines.
// */
////+(UILabel*) createTextLabel:(CGRect) lblRect withText:(NSString *) withText
//;
//
///**
// Creates a UILabel with custom values.
// */
////+ (UILabel *)labelWithTitle: (NSString *)title
////                      frame:(CGRect)frame
////                   textSize:(float)textSize
////                  textLines:(int)textLines
////                  textAlign:(NSTextAlignment)textAlign
////                  textColor:(UIColor *)textColor
////                  backColor:(UIColor *)backColor
////                     isBold:(BOOL)isBold
////;
//
////+(UILabel *) labelWithTitleColorFont:(NSString *)title
////                               frame:(CGRect)frame
////                           textLines:(int)textLines
////                           textAlign:(NSTextAlignment)textAlign
////                           textColor:(UIColor *)textColor
////                           backColor:(UIColor *)backColor
////                            textFont:(UIFont *) textFont
////
////;
//
//
//
//
//#pragma mark -
//#pragma mark Text Fields Creation
//#pragma mark -
//
///**
// Creates UITextField with preset values.
// */
////+(UITextField *) createTextField:(CGRect) fieldRect withText:(NSString *) withText
////;
//
///**
// Creates UITextField with custom values.
// */
//+(UITextField *) createTextField:(CGRect) fieldRect
//                        withText:(NSString *) withText
//                 backgroundColor:(UIColor*)backgroundColor
//                     placeholder:(NSString*)placeholder
//                       textColor:(UIColor*)textColor
//                   textAlignment:(NSTextAlignment)textAlignment font:(UIFont*)font
//					keyboardType:(UIKeyboardType)keyboardType
//;
//#pragma mark -
//#pragma mark Button Creation
//#pragma mark -
//#pragma mark -
//#pragma mark Buttons
//#pragma mark -
//
///**
// Creates UIButton with custom values.
// */
//+ (UIButton *)buttonWithTitle:	(NSString *)title
//					   target:(id)target
//					 selector:(SEL)selector
//						frame:(CGRect)frame
//						image:(UIImage *)image
//				 imagePressed:(UIImage *)imagePressed
//				darkTextColor:(BOOL)darkTextColor
//;
//
///**
// Creates UIButton with custom values.
// */
//+ (UIButton *)buttonWithTitle:	(NSString *)title
//					   target:(id)target
//					 selector:(SEL)selector
//						frame:(CGRect)frame
//						image:(UIImage *)image
//				 imagePressed:(UIImage *)imagePressed
//					 textSize:(float)textSize
//					textColor:(UIColor *)textColor
//					backColor:(UIColor *)backColor
//					   isBold:(BOOL)isBold
//;
//
///**
// Creates UIButton with custom values.
// */
//+(UIButton *)createButtonWithFrame:(CGRect)frame
//						 withImage: (UIImage *)btnImage
//				  withImagePressed:(UIImage *)btnImagePressed
//						 withTitle:(NSString *)btnTitle
//				  withUIEdgeInsets:(UIEdgeInsets)uiEdgeInsets
//					 titleFontSize:(float)size
//;


#pragma mark -
#pragma mark NSDate
#pragma mark -

+ (NSString*) getStringFromDate:(NSDate*)aDate inFormat:(NSString*)aFormat
;

/**
 Returns NSDate* from string in the specified format
 */
+ (NSDate*) getDateFromString:(NSString*)aString withFormat:(NSString*)aFormat
;

+(NSString*)getStringFromDifferentDateFormat:(NSString*)dateString format:(NSString*)dateFormat
;
/**
 Returns NSString* from string in the specified format
 */
+ (NSString*) getFormattedStringDateFromString:(NSString*)aString withFormat:(NSString*)aFormat
;


@end
