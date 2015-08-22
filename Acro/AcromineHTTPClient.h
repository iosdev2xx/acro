//
//  AcromineHTTPClient.h
//
//  Copyright (c) 2015
//

#import "AFHTTPSessionManager.h"


@protocol AcromineHTTPClientDelegate;


@interface AcromineHTTPClient : AFHTTPSessionManager

@property (nonatomic, weak) id<AcromineHTTPClientDelegate>delegate;

- (instancetype)initWithBaseURL:(NSURL *)url;

- (void)fetchLongFormsForAcronym:(NSString *)acronym;

@end


@protocol AcromineHTTPClientDelegate <NSObject>

@optional

- (void)acromineHTTPClient:(AcromineHTTPClient *)client didFetchLongForms:(id)longForms;
- (void)acromineHTTPClient:(AcromineHTTPClient *)client didFailFetchingLongFormsWithError:(NSError *)error;

@end
