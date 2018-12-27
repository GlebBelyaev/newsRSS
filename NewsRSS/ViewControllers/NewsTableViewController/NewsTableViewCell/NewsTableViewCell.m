//
//  NewsTableViewCell.m
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsModel.h"

@interface NewsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end


@implementation NewsTableViewCell

- (void)setNews:(NewsModel *)inputNews {
    if (inputNews == _news) return;
    
    _news = inputNews;
    
    self.titleLabel.text        = _news.title;
    self.descriptionLabel.text  = _news.newsDescription;
}

@end
