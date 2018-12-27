//
//  ApiServece.m
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "ApiService.h"

#import "NewsModel.h"
#import "NewsRSSErrorModel.h"

@interface ApiService()

@property (strong, nonatomic) NSURLSession *session;

@end

NSString * const hostURL    = @"https://newsapi.org/v2/everything?q=bitcoin";
NSString * const apiKey     = @"bacca4a7cf46442987209460a8bfebdd";
const int pageSize          = 20;

@implementation ApiService

- (instancetype)init {
    self = [super init];
    if (self) {
        self.session = [NSURLSession sharedSession];
    }
    return self;
}

- (void)getNewsFromPage:(NSInteger)page withCompletionBlock:(void (^)(id result, NewsRSSErrorModel *error))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"%@&from=2018-12-26&sortBy=publishedAt&apiKey=%@&pageSize=%d&page=%ld", hostURL, apiKey, pageSize, page];
    
//    ERROR DATE
//    NSString *urlString = [NSString stringWithFormat:@"%@&from=2018-10-26&sortBy=publishedAt&apiKey=%@&pageSize=%d&page=%d", hostURL, apiKey, pageSize, page];
    
//    //ERROR COUNT
//    NSString *urlString = [NSString stringWithFormat:@"%@&from=2018-12-24&sortBy=publishedAt&apiKey=%@&pageSize=%d&page=%d", hostURL, apiKey, pageSize, 10];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *requestTask = [self.session dataTaskWithURL:url completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
        // internet issues
        if (error) {
            NewsRSSErrorModel *myError = [[NewsRSSErrorModel alloc] initWithTitle:@"Error" andDescription:error.localizedDescription];
            completion(nil, myError);
            return;
        }
        
        // server connection error
        if (!data) {
            NewsRSSErrorModel *myError = [[NewsRSSErrorModel alloc] initWithTitle:@"Server issue" andDescription:@"Please try late"];
            completion(nil, myError);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([self isErrorSatatusWith:json]) {
            
            NSString *title = [json valueForKey:@"code"] ? [json valueForKey:@"code"] : @"Error" ;
            NSString *errroDescription = [json valueForKey:@"message"] ? [json valueForKey:@"message"] : @"Error";
            
            NewsRSSErrorModel *myError = [[NewsRSSErrorModel alloc] initWithTitle:title andDescription:errroDescription];
            completion(nil, myError);
            return;
            
        } else {
            completion([self newsFrom:json], nil);
        }
    }];
    
    [requestTask resume];
}

- (BOOL)isErrorSatatusWith:(NSDictionary *)json{
    if ([[json valueForKey:@"status"] isEqual:@"ok"]) return NO;
    return YES;
}

- (NSArray *)newsFrom:(NSDictionary *)json{
    NSMutableArray *result = [NSMutableArray new];
    NSArray *newsArray = [json valueForKey:@"articles"];
    for (NSDictionary *newsJson in newsArray) {
        NewsModel *model = [[NewsModel alloc] initWithJSON:newsJson];
        [result addObject:model];
    }
    return result;
}

@end
