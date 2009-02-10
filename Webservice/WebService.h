//
//  WebService.h
//  AppReview
//
//  Created by Allerin on 08-11-13.
//  Copyright 2008 Allerin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebService : NSObject {
	NSString *url;
	NSString *method;
	BOOL finished;
}

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *method;


+ (NSData *)sendSyncRequest:(NSString *)aurl;
+ (NSData *)sendSyncPostRequest:(NSString *)aurl;
+ (NSData *)sendSyncPutRequest:(NSString *)aurl;
+ (NSData *)sendSyncDeleteRequest:(NSString *)aurl;
+ (NSData *)sendSyncRequest:(NSString *)aurl Method:(NSString *)aMethod;

+ (NSData*) encodeBase64: (NSData*)source;
+ (NSString*) encodeBase64String: (NSString*)source;

- (id)initWithUrl:(NSString *)aUrl method:(NSString *)aMethod;
- (NSData *)doRequest;

@end
