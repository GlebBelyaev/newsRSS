//
//  CurrentNewsViewController.m
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "NewsModel.h"

#import "CurrentNewsViewController.h"


@interface CurrentNewsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTV;
@property (weak, nonatomic) IBOutlet UITextView *linkTV;
@end

@implementation CurrentNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = self.news.title;
    self.titleLabel.text = self.news.title;
    self.bodyTV.text  = self.news.content;
    self.linkTV.text  = self.news.url;
}

@end
