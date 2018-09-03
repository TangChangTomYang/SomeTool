//
//  ViewController+test.m
//  LeftRightFresh
//
//  Created by yangrui on 2018/9/3.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "ViewController+test.h"
#import "MJRefresh.h"

@implementation ViewController (test)


- (void)example21{
    __weak __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 增加5条假数据
        for (int i = 0; i<10; i++) {
            [weakSelf.colors insertObject:MJRandomColor atIndex:0];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.mj_header endRefreshing];
        });
    }];
    self.collectionView.mj_header.backgroundColor = [UIColor whiteColor];
    [self.collectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 增加5条假数据
        //        for (int i = 0; i<5; i++) {
        //            [weakSelf.colors addObject:MJRandomColor];
        //        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.mj_footer endRefreshing];
        });
    }];
    // 默认先隐藏footer
    self.collectionView.mj_footer.backgroundColor = [UIColor whiteColor];
    self.collectionView.mj_footer.hidden = YES;
}


//#pragma mark - 示例代码
//#pragma mark UITableView + 下拉刷新 默认
//- (void)example01
//{
//    __weak __typeof(self) weakSelf = self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//    }];
//    
//    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
//}
//
//#pragma mark UITableView + 下拉刷新 动画图片
//- (void)example02
//{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    self.tableView.mj_header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    
//    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
//}
//
//#pragma mark UITableView + 下拉刷新 隐藏时间
//- (void)example03
//{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header.automaticallyChangeAlpha = YES;
//    
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 马上进入刷新状态
//    [header beginRefreshing];
//    
//    // 设置header
//    self.tableView.mj_header = header;
//}
//
//#pragma mark UITableView + 下拉刷新 隐藏状态和时间
//- (void)example04
//{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
//    
//    // 马上进入刷新状态
//    [header beginRefreshing];
//    
//    // 设置header
//    self.tableView.mj_header = header;
//}
//
//#pragma mark UITableView + 下拉刷新 自定义文字
//- (void)example05
//{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    
//    // 设置文字
//    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
//    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
//    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
//    
//    // 设置字体
//    header.stateLabel.font = [UIFont systemFontOfSize:15];
//    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
//    
//    // 设置颜色
//    header.stateLabel.textColor = [UIColor redColor];
//    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
//    
//    // 马上进入刷新状态
//    [header beginRefreshing];
//    
//    // 设置刷新控件
//    self.tableView.mj_header = header;
//}
//
//#pragma mark UITableView + 下拉刷新 自定义刷新控件
//- (void)example06
//{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    self.tableView.mj_header = [MJDIYHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [self.tableView.mj_header beginRefreshing];
//}
//
//#pragma mark UITableView + 上拉刷新 默认
//- (void)example11
//{
//    [self example01];
//    
//    __weak __typeof(self) weakSelf = self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];
//    //    ((MJRefreshAutoFooter *)self.tableView.mj_footer).onlyRefreshPerDrag = YES;
//}
//
//#pragma mark UITableView + 上拉刷新 动画图片
//- (void)example12
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableView.mj_footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//}
//
//#pragma mark UITableView + 上拉刷新 隐藏刷新状态的文字
//- (void)example13
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJChiBaoZiFooter *footer = [MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
//    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
//    
//    // 隐藏刷新状态的文字
//    footer.refreshingTitleHidden = YES;
//    
//    // 设置footer
//    self.tableView.mj_footer = footer;
//}
//
//#pragma mark UITableView + 上拉刷新 全部加载完毕
//- (void)example14
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
//    
//    // 其他
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"恢复数据加载" style:UIBarButtonItemStyleDone target:self action:@selector(reset)];
//}
//
//- (void)reset
//{
//    [self.tableView.mj_footer setRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    [self.tableView.mj_footer resetNoMoreData];
//}
//
//#pragma mark UITableView + 上拉刷新 禁止自动加载
//- (void)example15
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    // 禁止自动加载
//    footer.automaticallyRefresh = NO;
//    
//    // 设置footer
//    self.tableView.mj_footer = footer;
//}
//
//#pragma mark UITableView + 上拉刷新 自定义文字
//- (void)example16
//{
//    [self example01];
//    
//    // 添加默认的上拉刷新
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    
//    // 设置文字
//    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
//    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
//    
//    // 设置字体
//    footer.stateLabel.font = [UIFont systemFontOfSize:17];
//    
//    // 设置颜色
//    footer.stateLabel.textColor = [UIColor blueColor];
//    
//    // 设置footer
//    self.tableView.mj_footer = footer;
//}
//
//#pragma mark UITableView + 上拉刷新 加载后隐藏
//- (void)example17
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadOnceData方法）
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadOnceData)];
//}
//
//#pragma mark UITableView + 上拉刷新 自动回弹的上拉01
//- (void)example18
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    // 设置了底部inset
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//    // 忽略掉底部inset
//    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
//}
//
//#pragma mark UITableView + 上拉刷新 自动回弹的上拉02
//- (void)example19
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
//    self.tableView.mj_footer = [MJChiBaoZiFooter2 footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
//    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
//}
//
//#pragma mark UITableView + 上拉刷新 自定义刷新控件(自动刷新)
//- (void)example20
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableView.mj_footer = [MJDIYAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//}
//
//#pragma mark UITableView + 上拉刷新 自定义刷新控件(自动回弹)
//- (void)example21
//{
//    [self example01];
//    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    self.tableView.mj_footer = [MJDIYBackFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//}
@end
