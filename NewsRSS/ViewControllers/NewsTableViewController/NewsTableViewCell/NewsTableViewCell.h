//
//  NewsTableViewCell.h
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell

@property (strong, nonatomic) NewsModel *news;

@end

NS_ASSUME_NONNULL_END
