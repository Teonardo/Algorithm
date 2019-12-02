//
//  ViewController.m
//  Algorithm
//
//  Created by Teonardo on 2019/12/2.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "ViewController.h"
#import "Bin_packingProblemVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"算法";
    
    [self prepareData];
    
    [self addTableView];
    
}

#pragma mark - UI

- (void)addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    [self.view addSubview:tableView];
//    tableView.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.rowHeight = 50;
    tableView.tableFooterView = [UIView new];

    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    tableView.frame = self.view.bounds;
}


#pragma mark - Action

#pragma mark - Delegate

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class =  [self.dataArr[indexPath.row] lastObject];
    UIViewController *vc = [class new];
    vc.navigationItem.title = [self.dataArr[indexPath.row] firstObject];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArr[indexPath.row] firstObject];
    
    return cell;
}

#pragma mark - Private Method
- (void)prepareData {
    self.dataArr = @[
                     @[@"装箱问题", [Bin_packingProblemVC class]]
                    ].mutableCopy;
}

#pragma mark - Setter

#pragma mark - Getter



@end
