//
//  ViewController.m
//  iOS 实现步骤进度条
//
//  Created by Mac-Qke on 2018/11/30.
//  Copyright © 2018 Mac-Qke. All rights reserved.
//

#import "ViewController.h"
#import "QLStepView.h"
@interface ViewController ()
@property (nonatomic, strong) QLStepView *qlStepView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 初始化
    _qlStepView = [[QLStepView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 60) titleArray:@[@"第一步",@"第二步",@"第三步"] stepIndex:0];
    [self.view addSubview:_qlStepView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //设置当前步骤，步骤索引 = 数字索引
    [_qlStepView setStepIndex:2 animation:YES];
}


@end
