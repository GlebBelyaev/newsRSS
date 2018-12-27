//
//  NewModel.m
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithJSON:(NSDictionary *)newsJSON {
    if (self = [super init]) {
        self.author = [self isEmptyObject:[newsJSON valueForKey:@"author"]] ? @"No author" : [newsJSON valueForKey:@"author"];
        self.title =  [self isEmptyObject:[newsJSON valueForKey:@"title"]] ?  @"No title" : [newsJSON valueForKey:@"title"];
        self.newsDescription = [self isEmptyObject:[newsJSON valueForKey:@"description"]] ?  @"No description" : [newsJSON valueForKey:@"description"] ;
        self.url = [self isEmptyObject:[newsJSON valueForKey:@"url"]] ?  @"No url" : [newsJSON valueForKey:@"url"];
        self.urlToImage =  [self isEmptyObject:[newsJSON valueForKey:@"urlToImage"]] ?  @"No urlToImage" : [newsJSON valueForKey:@"urlToImage"];
        self.publishedAt = [self isEmptyObject:[newsJSON valueForKey:@"publishedAt"]] ?  @"No publishedAt" : [newsJSON valueForKey:@"publishedAt"] ;;
        self.content = [self isEmptyObject:[newsJSON valueForKey:@"content"]] ?  @"No content" : [newsJSON valueForKey:@"content"] ;
    }
    return self;
}


#pragma mark - privat function

- (BOOL)isEmptyObject:(id) thing {
    return thing == nil || [thing isKindOfClass:[NSNull class]] || ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) || ([thing respondsToSelector:@selector(count)] && [(NSArray *)thing count] == 0);
}

@end
