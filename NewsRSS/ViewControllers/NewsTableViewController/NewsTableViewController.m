//
//  NewsTableViewController.m
//  NewsRSS
//
//  Created by gleb on 26/12/2018.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "NewsModel.h"
#import "NewsRSSErrorModel.h"

#import "NewsTableViewController.h"
#import "NewsTableViewCell.h"
#import "CurrentNewsViewController.h"

#import "ApiService.h"

@interface NewsTableViewController ()

@property (strong, nonatomic) IBOutlet UIView *indicatiorView;

@property (strong, nonatomic) NSMutableArray<NewsModel *> *newsArray;
@property (strong, nonatomic) ApiService  *apiServiceImp;
@property (assign, nonatomic) NSInteger   page;
@property (assign, nonatomic) BOOL        loadingProcesIsActive;
@property (assign, nonatomic) NSIndexPath *selectedItem;

@end

NSString * const cellIdent  = @"newsCellIdentifier";
NSString * const segueIdent = @"showNewsDetail";

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsArray = [NSMutableArray new];
    self.apiServiceImp = [[ApiService alloc] init];
    self.page = 1;
    self.loadingProcesIsActive = YES;
    
    
    [self setupUI];
    
    [self fillNews];

}

- (void)setupUI {
    
    [self.view addSubview:self.indicatiorView];
    self.indicatiorView.hidden = NO;
    self.indicatiorView.frame  = CGRectMake(0, 0, self.view.frame.size.width, 60);
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.39 green:0.77 blue:0.73 alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadData)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:segueIdent]) {
        CurrentNewsViewController *vc = segue.destinationViewController;
        vc.news = self.newsArray[self.selectedItem.row];
    }
}


#pragma mark - work with data
- (void)fillNews {
    __weak typeof(self) weakSelf = self;
    [self.apiServiceImp getNewsFromPage:self.page withCompletionBlock:^(id result, NewsRSSErrorModel *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showError:error];
            });
        } else {
            NSArray *inputNewsArray = result;
            
            if (inputNewsArray.count != 0) {
                [weakSelf.newsArray addObjectsFromArray:inputNewsArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }
        }
        weakSelf.loadingProcesIsActive = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.indicatiorView.hidden = YES;
            [weakSelf.refreshControl endRefreshing];
        });
    }];
}

- (void)getNextPage {
    self.page ++;
    [self fillNews];
}

- (void)reloadData {
    self.page = 1;
    [self.newsArray removeAllObjects];
    [self.tableView reloadData];
    [self fillNews];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    cell.news = self.newsArray[indexPath.row];
    
    if (indexPath.row + 5 == self.newsArray.count && !self.loadingProcesIsActive) {
        self.loadingProcesIsActive = YES;
        [self getNextPage];
    }
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedItem = indexPath;
    [self performSegueWithIdentifier:segueIdent sender:self];
}

#pragma mark - show error
- (void)showError:(NewsRSSErrorModel *)error {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:error.title
                                 message:error.localDescription
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    if(![error.title isEqualToString:@"sourceDoesNotExist"]) {
        UIAlertAction* tryAgainButton = [UIAlertAction
                                         actionWithTitle:@"Try again"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             [self fillNews];
                                         }];
        [alert addAction:tryAgainButton];
    }
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
