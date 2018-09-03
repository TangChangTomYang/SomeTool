//
//  ViewController.h
//  LeftRightFresh
//
//  Created by yangrui on 2018/8/31.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 随机色
 */
#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface ViewController : UIViewController

@property (strong, nonatomic) UICollectionView *collectionView;
/** 存放假数据 */
@property (strong, nonatomic) NSMutableArray *colors;
@end

