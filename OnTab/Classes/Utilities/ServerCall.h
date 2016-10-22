//
//  ServerCall.h
//  photolab
//
//  Created by Mountain on 4/11/13.
//  Copyright (c) 2013 Mountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"

@protocol ServerCallDelegate;
@interface ServerCall : NSObject {

    id <ServerCallDelegate> delegate;
}

@property (nonatomic, strong) id <ServerCallDelegate> delegate;
@property (nonatomic,retain) NSString *methodType;
@property (nonatomic,retain) NSString *urlStr;
@property (nonatomic, readwrite) int nTag;

- (void) CallApi;
- (void) requestServer:(NSString*) strUrl;
- (void) uploadVideo: (NSString*)strUrl data:(NSDictionary*) dictInfo dataMedia:(NSData*)dataMedia;
- (void) uploadPhoto: (NSString*)strUrl data:(NSDictionary*) dictInfo dataMedia:(NSData*)dataMedia  photoName:(NSString*)strName;
- (void) requestServerOnPost:(NSString*) strUrl data:(NSDictionary*) dictInfo;
- (void) getOauthDataUsingHMAC;

@end

@protocol ServerCallDelegate

- (void) OnReceived: (NSDictionary*) dictData;

@optional

- (void)internetNotAvailable:(NSString *)errorMessage;

@end