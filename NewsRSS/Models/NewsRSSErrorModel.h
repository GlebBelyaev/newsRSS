//
//  NewsRSSErrorModel.h
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsRSSErrorModel : NSObject

- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)localDescription;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *localDescription;


@end

NS_ASSUME_NONNULL_END
