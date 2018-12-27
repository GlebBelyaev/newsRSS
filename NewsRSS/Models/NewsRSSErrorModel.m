//
//  NewsRSSErrorModel.m
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "NewsRSSErrorModel.h"

@implementation NewsRSSErrorModel

- (instancetype)initWithTitle:(NSString *)title andDescription:(NSString *)localDescription {
    if((self = [super init])){
        self.title = title;
        self.localDescription = localDescription;
    }
    return self;
}

@end
