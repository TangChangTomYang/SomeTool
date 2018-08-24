//
//  ViewController.m
//  GSKeyChainMgr
//
//  Created by yangrui on 2018/8/24.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "ViewController.h"
#import "GSKeyChainDataManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *uuid = [GSKeyChainDataManager readUUID];
    NSLog(@"%@",uuid);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
