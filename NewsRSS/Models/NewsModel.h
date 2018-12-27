//
//  NewModel.h
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *newsDescription;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *urlToImage;
@property (strong, nonatomic) NSString *publishedAt;
@property (strong, nonatomic) NSString *content;

- (instancetype)initWithJSON:(NSDictionary *)newsJSON;

@end

NS_ASSUME_NONNULL_END
