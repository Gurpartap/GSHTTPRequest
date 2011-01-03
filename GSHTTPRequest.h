//
//  GSHTTPRequest.h
//  TwitPic Uploader
//
//  Created by Gurpartap Singh on 01/01/11.
//  Copyright 2011 Gurpartap Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GSHTTPRequestDelegate

- (void)requestSucceeded:(NSDictionary *)response HTTPRequest:(id)HTTPRequest;
- (void)requestFailed:(NSDictionary *)response HTTPRequest:(id)HTTPRequest;

@end


@interface GSHTTPRequest : NSObject {
  __weak NSObject <GSHTTPRequestDelegate> *_delegate;
  NSURLRequest *_request;
  NSMutableData *_data;
  
  NSInteger _statusCode;
}

@property (nonatomic, retain) NSURLRequest *_request;
@property (nonatomic, retain) NSMutableData *_data;

+ (GSHTTPRequest *)HTTPRequestWithURLRequest:(NSURLRequest *)request delegate:(NSObject *)theDelegate;
- (GSHTTPRequest *)initWithURLRequest:(NSURLRequest *)request delegate:(NSObject *)delegate;
- (void)startURLConnection;

- (BOOL)_isValidDelegateForSelector:(SEL)selector;

@end
