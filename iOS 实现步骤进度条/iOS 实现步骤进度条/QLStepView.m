//
//  QLStepView.m
//  iOS 实现步骤进度条
//
//  Created by Mac-Qke on 2018/11/30.
//  Copyright © 2018 Mac-Qke. All rights reserved.
//

#import "QLStepView.h"
//步骤条主题色
#define TINT_COLOR [UIColor colorWithRed:35/255.f green:135/255.f  blue:255/255.f  alpha:1]

@interface QLStepView ()

@property (nonatomic,copy) NSArray *titleArray;
@property (nonatomic, assign) NSUInteger stepIndex;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) NSMutableArray *circleViewArray;
@property (nonatomic, strong) NSMutableArray *titleLabelArray;
@property (nonatomic, strong) UILabel *indicatorLabel;
@end

@implementation QLStepView

#pragma mark -- Init

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray stepIndex:(NSUInteger)stepIndex {
    self = [self initWithFrame:frame];
    if (self) {
        _titleArray = [titleArray copy];
        _stepIndex = stepIndex;
        
        // 进度条
        [self addSubview:self.progressView];
        
        for (NSString *title in _titleArray) {
            //圆圈
            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
            circle.backgroundColor = [UIColor lightGrayColor];
            circle.layer.cornerRadius = 13.0f / 2;
            [self addSubview:circle];
            [self.circleViewArray addObject:circle];
            
            //标题
            UILabel *label = [[UILabel alloc] init];
            label.text = title;
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [self.titleLabelArray addObject:label];
            
            
        }
        
        //当前索引数字
        [self addSubview:self.indicatorLabel];
        
        
    }
    
    return self;
}




//布局更新界面元素
- (void)layoutSubviews{
    NSInteger perWidth = self.frame.size.width / self.titleArray.count;
    
    //进度条
    self.progressView.frame = CGRectMake(0, 0, self.frame.size.width-perWidth, 1);
    self.progressView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height/4);
    
    
    CGFloat startX = self.progressView.frame.origin.x;
    for (int i = 0; i < self.titleArray.count; i++) {
        //圆圈
        UIView *cycle = self.circleViewArray[i];
        if (cycle) {
            cycle.center = CGPointMake(i * perWidth + startX, self.progressView.center.y);
        }
        
        //标题
        UILabel *label = self.titleLabelArray[i];
        if (label) {
            label.frame = CGRectMake(perWidth*i, self.frame.size.height / 2, self.frame.size.width / self.titleArray.count , self.frame.size.height / 2);
        }
        
       // self.stepIndex = self.stepIndex;
    }
    
    
}

#pragma mark - Custom Accessors
- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = TINT_COLOR;
        _progressView.progress = self.stepIndex / ((self.titleArray.count - 1) * 1.0);
    }
    
    return _progressView;
}

- (UILabel *)indicatorLabel {
    if (!_indicatorLabel) {
        _indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
        _indicatorLabel.textColor = TINT_COLOR;
        _indicatorLabel.textAlignment = NSTextAlignmentCenter;
        _indicatorLabel.backgroundColor = [UIColor whiteColor];
        _indicatorLabel.layer.cornerRadius = 23.0f / 2;
        _indicatorLabel.layer.borderColor = [TINT_COLOR CGColor];
        _indicatorLabel.layer.borderWidth = 1;
        _indicatorLabel.layer.masksToBounds = YES;
        
    }
    
    
    return _indicatorLabel;
}

- (NSMutableArray *)circleViewArray {
    if (!_circleViewArray) {
        _circleViewArray = [[NSMutableArray alloc] initWithCapacity:self.titleArray.count];
    }
    
    
    return _circleViewArray;
}

- (NSMutableArray *)titleLabelArray {
    if (!_titleLabelArray) {
        _titleLabelArray = [[NSMutableArray alloc] initWithCapacity:self.titleArray.count];
    }
    
    return _titleLabelArray;
}

// 设置当前进度索引，更新圆形图片，文本颜色，当前索引数字
- (void)setStepIndex:(NSUInteger)stepIndex{
    for (int i=0; i < self.titleArray.count; i++) {
        UIView *cycle = self.circleViewArray[i];
        UILabel *label = self.titleLabelArray[i];
        if (stepIndex >= i) {
            cycle.backgroundColor = TINT_COLOR;
            label.textColor = TINT_COLOR;
        }else{
            cycle.backgroundColor = [UIColor lightGrayColor];
            label.textColor = [UIColor lightGrayColor];
            
        }
    }
    
}

#pragma mark -- Public
- (void)setStepIndex:(NSUInteger)stepIndex animation:(BOOL)animation {
    if (stepIndex < self.titleArray.count) {
        //更新颜色
        self.stepIndex = stepIndex;
        //设置进度条
        [self.progressView setProgress:stepIndex / ((self.titleArray.count - 1) * 1.0) animated:animation];
        //设置当前索引数字
        self.indicatorLabel.text = [NSString stringWithFormat:@"%lu",stepIndex +1];
        self.indicatorLabel.center  = ((UIView *)[self.circleViewArray objectAtIndex:stepIndex]).center;
    }
}
@end
