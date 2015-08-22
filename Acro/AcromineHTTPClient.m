//
//  AcromineHTTPClient.m
//
//  Copyright (c) 2015
//

#import "AcromineHTTPClient.h"


static NSString * const AcromineURLString = @"http://www.nactem.ac.uk/software/acromine/";


@implementation AcromineHTTPClient

- (instancetype)init {
    NSURL *acromineURL = [NSURL URLWithString:AcromineURLString];

    return [self initWithBaseURL:acromineURL];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url sessionConfiguration:nil];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // The Acromine service returns text/plain content type
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",nil];
    }
    
    return self;
}

- (void)fetchLongFormsForAcronym:(NSString *)acronym {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"sf"] = acronym;
        
    [self GET:@"dictionary.py" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(acromineHTTPClient:didFetchLongForms:)]) {
            [self.delegate acromineHTTPClient:self didFetchLongForms:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(acromineHTTPClient:didFailFetchingLongFormsWithError:)]) {
            [self.delegate acromineHTTPClient:self didFailFetchingLongFormsWithError:error];
        }
    }];
}

@end
