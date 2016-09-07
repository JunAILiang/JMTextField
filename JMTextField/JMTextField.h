//
//  JMTextField.h
//  JMTextField
//
//  Created by 刘俊敏 on 16/9/5.
//  Copyright © 2016年 刘俊敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMTextFiledDelegate <NSObject>

@optional
- (void)returnTextFiledText:(NSString *)text;

@end

@interface JMTextField : UITextField

/* 初始化并返回一个新的AZXEmailTextField，自定义其Frame以及superview */
- (instancetype)initWithFrame:(CGRect)frame InView:(UIView *)view;

/** 输入框的颜色 */
@property (nonatomic, strong) UIColor *textFiledColor;

/** 设置cell线条的颜色(默认 lightGrayColor) */
@property (nonatomic, strong) UIColor *cellLineColor;

/** 设置cell文字的颜色(默认 blackColor) */
@property (nonatomic, strong) UIColor *cellTextColor;

/** 设置cell文字的大小(默认 16) */
@property (nonatomic, assign) CGFloat cellTextSize;

/** 设置cell的高度(默认 30) */
@property (nonatomic, assign) CGFloat cellHeight;

/** 设置tableView的高度(默认 全屏) */
@property (nonatomic, assign) CGFloat tableViewHeight;

/** tableView是否全屏(默认 全屏 相对父视图) */
@property (nonatomic, assign) BOOL isFullScreen;

/** 声明代理 */
@property (nonatomic, weak) id <JMTextFiledDelegate>delegate;

@end
