//
//  ViewController.m
//  LeftRightFresh
//
//  Created by yangrui on 2018/8/31.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+test.h"
#import "MJRefresh.h"



@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation ViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // UICollectionViewFlowLayout的初始化（与刷新控件无关）
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(80, 80);
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        layout.minimumInteritemSpacing = 20;
        layout.minimumLineSpacing = 20;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        
        CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 200);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
          [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"aaa"];
        _collectionView.alwaysBounceHorizontal = YES;
        _collectionView.alwaysBounceVertical = NO;
        [self.view addSubview:_collectionView];
  
    }
    return _collectionView;

}

#pragma mark - 数据相关
- (NSMutableArray *)colors
{
    if (!_colors) {
        self.colors = [NSMutableArray array];
    }
    return _colors;
}









- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
  
    [self colors];
    [self collectionView];
    [self example21];
}

#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 设置尾部控件的显示和隐藏
    self.collectionView.mj_footer.hidden = self.colors.count == 0;
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"aaa" forIndexPath:indexPath];
    cell.backgroundColor = self.colors[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"========indexPath: %@",indexPath);
}


@end
