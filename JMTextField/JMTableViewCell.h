//
//  JMTableViewCell.h
//  JMTextField
//
//  Created by 刘俊敏 on 16/9/6.
//  Copyright © 2016年 刘俊敏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMTableViewCell : UITableViewCell

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

/** 图片 */
@property (nonatomic, weak) UIImageView *imageIV;

/** 文字 */
@property (nonatomic, weak) UILabel *text;

/** 线条 */
@property (nonatomic, weak) UIView *line;

/** error按钮 */
@property (nonatomic, weak) UIButton *errorBtn;

@end
