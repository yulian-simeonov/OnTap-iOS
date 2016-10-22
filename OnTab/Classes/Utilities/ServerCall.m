//
//  ServerCall.m
//  photolab
//
//  Created by Mountain on 4/11/13.
//  Copyright (c) 2013 Mountain. All rights reserved.
//

#import "ServerCall.h"
#import "SVProgressHUD.h"
#import "Utilities.h"
#import "OADataFetcher.h"

@implementation ServerCall

@synthesize delegate, urlStr, methodType, nTag;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) uploadPhoto: (NSString*)strUrl data:(NSDictionary*) dictInfo dataMedia:(NSData*)dataMedia photoName:(NSString*)strName {
    
    //    NSData *dataImg = [NSData dataWithContentsOfFile:strImgPath];
    NSLog(@"Param=%@,", dictInfo);
    
    [SVProgressHUD show];
    
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setDelegate:self];
    [request setRequestMethod:@"POST"];
    
    NSArray *arrKey = (NSArray*)[dictInfo allKeys];
    for (int i=0; i<arrKey.count; i++) {
        [request setPostValue:[dictInfo objectForKey:[arrKey objectAtIndex:i]] forKey:[arrKey objectAtIndex:i]];
    }
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    NSData* dataImg = UIImageJPEGRepresentation([UIImage imageNamed:@"btn_back.png"], 1.0);
    [request addData:dataMedia withFileName:strName andContentType:contentType forKey:strName];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setTimeOutSeconds:5];
    [request setNumberOfTimesToRetryOnTimeout:1];
    [request startAsynchronous];
}

- (void) uploadVideo: (NSString*)strUrl data:(NSDictionary*) dictInfo dataMedia:(NSData*)dataMedia {

//    NSData *dataImg = [NSData dataWithContentsOfFile:strImgPath];
    NSLog(@"Param=%@,", dictInfo);
    
    [SVProgressHUD show];
    
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setDelegate:self];
    [request setRequestMethod:@"POST"];
    
    NSArray *arrKey = (NSArray*)[dictInfo allKeys];
    for (int i=0; i<arrKey.count; i++) {
        [request setPostValue:[dictInfo objectForKey:[arrKey objectAtIndex:i]] forKey:[arrKey objectAtIndex:i]];
    }
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    dataImg = UIImageJPEGRepresentation([UIImage imageNamed:@"button-main-camera@2x.png"], 1.0);
    [request addData:dataMedia withFileName:@"video.mov" andContentType:contentType forKey:@"video"];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setTimeOutSeconds:5];
    [request setNumberOfTimesToRetryOnTimeout:1];
    [request startAsynchronous];
}

- (void) getOauthDataUsingHMAC
{
    OAConsumer *consumer = [[OAConsumer alloc] initWithKey:@"39627c2e844143a5f2e0538be018cd3e1693ac8e1a10d299bfe738b3f54a40cc"
                                                    secret:@"6dc9443a62e57875c6858242971a5fa183c78fa89ba2d349b61100f2ebac5298"];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:url
                                                                   consumer:consumer
                                                                      token:NULL
                                                                      realm:NULL
                                                          signatureProvider:nil andMethodType:self.methodType];
    
    OADataFetcher *fetcher = [[OADataFetcher alloc] init];
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(requestTokenTicket:finishedWithData:)
                  didFailSelector:@selector(requestTokenTicket:failedWithError:)];
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket finishedWithData:(NSMutableData *)data {
    
    NSLog(@"Success requestTokenTicket");
    if ([self.methodType isEqualToString:@"POST"])
    {
        [self performSelectorOnMainThread:@selector(fetchDataForTicket:)
                               withObject:ticket
                            waitUntilDone:YES];
    }
    else if ([self.methodType isEqualToString:@"GET"])
    {
        [self performSelectorOnMainThread:@selector(getDataForTicket:)
                               withObject:ticket
                            waitUntilDone:YES];
    }
    
}

- (void)requestTokenTicket:(OAServiceTicket *)ticket failedWithError:(NSError *)error
{
    
    if ([self.methodType isEqualToString:@"POST"])
    {
        [self performSelectorOnMainThread:@selector(fetchDataForTicket:)
                               withObject:ticket
                            waitUntilDone:YES];
    }
    else if ([self.methodType isEqualToString:@"GET"])
    {
        [self performSelectorOnMainThread:@selector(getDataForTicket:)
                               withObject:ticket
                            waitUntilDone:YES];
    }
}

-(void)fetchDataForTicket:(OAServiceTicket *)ticket {

    
}

-(void)getDataForTicket:(OAServiceTicket *)ticket {

    
}

- (void) requestServer:(NSString*) strUrl {
    
    //    /api/create_user.php?userid=wangdasan&username=Wang Da San&email=wangdasan@hotmail.com&password=lovekim&phone=18904150992
    NSLog(@"%@", strUrl);
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setDelegate:self];
    [request setRequestMethod:@"GET"];
    [SVProgressHUD show];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setTimeOutSeconds:5];
    [request setNumberOfTimesToRetryOnTimeout:1];
    [request startAsynchronous];
}

- (void) requestServerOnPost:(NSString*) strUrl data:(NSDictionary*) dictInfo {
    
    [SVProgressHUD show];
    
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setDelegate:self];
    [request setRequestMethod:@"POST"];
    NSArray *arrKey = (NSArray*)[dictInfo allKeys];
    for (int i=0; i<arrKey.count; i++) {
        [request setPostValue:[dictInfo objectForKey:[arrKey objectAtIndex:i]] forKey:[arrKey objectAtIndex:i]];
    }                                                                                                                               
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request setTimeOutSeconds:5];
    [request setNumberOfTimesToRetryOnTimeout:1];
    [request startAsynchronous];
}

- (void)requestDone:(ASIFormDataRequest*)request {
    
    NSLog(@"%@", [request responseString] );
    NSString* response = [request responseString];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [SVProgressHUD dismiss];
    [self.delegate OnReceived:(NSDictionary*) [response JSONValue]];
}

- (void)requestFailed:(ASIFormDataRequest*)request {
    
    [SVProgressHUD dismiss];
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    [Utilities showMsg:@"Server connnection failed."];
    
    [APPDELEGATE didLogOut];
}

- (void) CallApi {

    [delegate OnReceived:[[NSDictionary alloc] initWithObjectsAndKeys:@"test", @"test", nil]];
}

@end
 