//
//  GSHTTPRequest.m
//  TwitPic Uploader
//
//  Created by Gurpartap Singh on 01/01/11.
//  Copyright 2011 Gurpartap Singh. All rights reserved.
//

#import "GSHTTPRequest.h"


@implementation GSHTTPRequest

@synthesize _request;
@synthesize _data;

+ (GSHTTPRequest *)HTTPRequestWithURLRequest:(NSURLRequest *)request delegate:(NSObject *)theDelegate {
  return [[[self alloc] initWithURLRequest:request delegate:theDelegate] autorelease];
}


- (GSHTTPRequest *)initWithURLRequest:(NSURLRequest *)request delegate:(NSObject *)delegate {
  if (self = [super init]) {
    _delegate = delegate;
    self._request = request;
    _data = [[NSMutableData alloc] init];
  }
  return self;
}


- (void)startURLConnection {
  if (![[NSURLConnection connectionWithRequest:_request delegate:self] retain]) {
    // TODO: Send requestFailed.
  }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  _statusCode = (NSInteger)[(NSHTTPURLResponse *)response statusCode];
  [_data setLength:0];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [_data appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  NSMutableDictionary *response = [[[NSMutableDictionary alloc] init] autorelease];
  NSString *responseString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
  
  [response setObject:_request forKey:@"request"];
  [response setObject:responseString forKey:@"responseString"];
  [response setObject:[NSNumber numberWithInt:_statusCode] forKey:@"responseStatusCode"];
  
  if ([self _isValidDelegateForSelector:@selector(requestSucceeded:HTTPRequest:)]) {
    [_delegate requestSucceeded:response HTTPRequest:self];
  }
  
  [connection release];
  _request = nil;
  [_data setLength:0];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  NSMutableDictionary *response = [[[NSMutableDictionary alloc] init] autorelease];
  NSString *responseString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
  
  [response setObject:_request forKey:@"request"];
  [response setObject:responseString forKey:@"responseString"];
  [response setObject:[NSNumber numberWithInt:_statusCode] forKey:@"responseStatusCode"];
  
  if ([self _isValidDelegateForSelector:@selector(requestFailed:HTTPRequest:)]) {
    [_delegate requestFailed:response HTTPRequest:self];
  }
  
  [connection release];
  _request = nil;
  [_data setLength:0];
}


- (BOOL)_isValidDelegateForSelector:(SEL)selector {
  return ((_delegate != nil) && [_delegate respondsToSelector:selector]);
}


- (void)dealloc {
  _delegate = nil;
  [super dealloc];
}

@end
