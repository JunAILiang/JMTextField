//
//  JMTableViewCell.m
//  JMTextField
//
//  Created by 刘俊敏 on 16/9/6.
//  Copyright © 2016年 刘俊敏. All rights reserved.
//

#import "JMTableViewCell.h"

@implementation JMTableViewCell

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ID";
    JMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[JMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imageIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"history"]];
        _imageIV = imageIV;
        [self.contentView addSubview:imageIV];
        
        UILabel *text = [[UILabel alloc] init];
        _text = text;
        [self.contentView addSubview:text];
        
        UIButton *errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorBtn = errorBtn;
        [errorBtn setImage:[UIImage imageNamed:@"error"] forState:UIControlStateNormal];
        [self.contentView addSubview:errorBtn];
        
        UIView *line = [[UIView alloc] init];
        _line = line;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat imageX = 10;
    CGFloat imageW = 20;
    CGFloat imageH = 20;
    CGFloat imageY = self.frame.size.height * 0.5 - imageH * 0.5;
    _imageIV.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat textX = CGRectGetMaxY(_imageIV.frame) + 10;
    CGFloat textW = self.frame.size.width - 100;
    CGFloat textH = 20;
    CGFloat textY = self.frame.size.height * 0.5 - textH * 0.5;
    _text.frame = CGRectMake(textX, textY, textW, textH);

    CGFloat btnX = self.frame.size.width - 40;
    CGFloat btnW = 40;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    _errorBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    CGFloat lineX = 10;
    CGFloat lineW = self.frame.size.width;
    CGFloat lineH = .6;
    CGFloat lineY = self.frame.size.height - 1;
    _line.frame = CGRectMake(lineX, lineY, lineW, lineH);
}

@end
