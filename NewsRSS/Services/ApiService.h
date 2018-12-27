//
//  ApiServece.h
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsRSSErrorModel;

NS_ASSUME_NONNULL_BEGIN

@interface ApiService : NSObject

- (void)getNewsFromPage:(NSInteger)page withCompletionBlock:(void (^)(id result, NewsRSSErrorModel *error))completion;

@end

NS_ASSUME_NONNULL_END
