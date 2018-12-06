//
//  QLStepView.h
//  iOS 实现步骤进度条
//
//  Created by Mac-Qke on 2018/11/30.
//  Copyright © 2018 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QLStepView : UIView
//指定初始化方法
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray stepIndex:(NSUInteger)stepIndex;

//设置当前步骤
- (void)setStepIndex:(NSUInteger)stepIndex animation:(BOOL)animation;
@end

NS_ASSUME_NONNULL_END
