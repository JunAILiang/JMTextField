//
//  JMTextField.m
//  JMTextField
//
//  Created by 刘俊敏 on 16/9/5.
//  Copyright © 2016年 刘俊敏. All rights reserved.
//

#import "JMTextField.h"
#import "JMTableViewCell.h"

#define saveDataKey @"DataKey"

@interface JMTextField ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
/** 下拉提示的tableView */
@property (nonatomic, weak) UITableView *tableView;
/** 本地数据数组 */
@property (nonatomic, strong) NSMutableArray *localArrM;
/** 引用view */
@property (nonatomic, strong) UIView *view;
/** 搜索按钮 */
@property (nonatomic, weak) UIButton *searchBtn;

#define FilePaths [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"ljm.plist"]
@end

@implementation JMTextField
- (NSMutableArray *)localArrM {
    if (!_localArrM) {
        _localArrM = [NSMutableArray array];
    }
    return _localArrM;
}
- (instancetype)initWithFrame:(CGRect)frame InView:(UIView *)view{
    if (self = [super initWithFrame:frame]) {
        //设置TF属性
        [self setUpTextFieldAttribute];
        
        self.view = view;
        self.isFullScreen = YES;

        //设置视图
        [self setUpView];
    }
    return self;
}

#pragma mark - 设置TF属性
- (void)setUpTextFieldAttribute {
    //键盘类型
    self.keyboardType = UIKeyboardTypeNumberPad;
    //样式
    self.layer.borderColor = self.textFiledColor ? self.textFiledColor.CGColor : [UIColor orangeColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5.f;
    //遵守代理
    self.delegate = self;
    //添加点击事件
    [self addTarget:self action:@selector(setUpView) forControlEvents:UIControlEventEditingDidBegin];
}

#pragma mark - 设置视图
- (void)setUpView{
    CGFloat tableViewX = self.isFullScreen ? self.view.frame.origin.x : self.frame.origin.x;
    CGFloat tableViewY = self.frame.origin.y;
    
    CGFloat tableViewH = self.tableViewHeight ? self.tableViewHeight : [UIScreen mainScreen].bounds.size.height - tableViewY - 49;
    CGFloat tableViewW = self.isFullScreen ? self.view.frame.size.width : self.frame.size.width;
    
    //btn
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn = searchBtn;
    searchBtn.frame = CGRectMake(CGRectGetMaxY(self.frame) + 75, CGRectGetMinY(self.frame), 60, 30);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 5.f;
    searchBtn.layer.borderWidth = .3;
    searchBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    //tableView
    
    //读取本地文件
    NSMutableArray *tempArrM = [NSMutableArray arrayWithContentsOfFile:FilePaths];
    self.localArrM = (NSMutableArray *)[[tempArrM reverseObjectEnumerator] allObjects];

    [self.tableView removeFromSuperview];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY + self.frame.size.height, tableViewW, tableViewH) style:UITableViewStylePlain];
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = view.bounds;
    [btn setTitle:@"清空搜索历史" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(removeAllClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    tableView.tableFooterView = view;
    
    if (self.localArrM.count <= 0 || self.localArrM == nil) {
        tableView.hidden = YES;
    } else {
        tableView.hidden = NO;
    }
    [self.view addSubview:tableView];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.localArrM = [NSMutableArray arrayWithContentsOfFile:FilePaths];
    if (textField.text.length <= 0 || textField.text == nil) {
        
    } else if(![self.localArrM containsObject:textField.text]){
        [self.localArrM addObject:textField.text];
        [self.localArrM writeToFile:FilePaths atomically:YES];
    }
    return YES;
}

- (void)searchBtnClick {
    self.localArrM = [NSMutableArray arrayWithContentsOfFile:FilePaths];
    if (self.text.length <= 0 || self.text == nil) {
        
    } else if(![self.localArrM containsObject:self.text]){
        [self.localArrM addObject:self.text];
        [self.localArrM writeToFile:FilePaths atomically:YES];
    }
    if ([self.delegate respondsToSelector:@selector(returnTextFiledText:)]) {
        [self.delegate returnTextFiledText:self.text];
    }
}

#pragma mark - UITableViewDelegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.localArrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JMTableViewCell *cell = [JMTableViewCell tableViewCellWithTableView:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.text.text = self.localArrM[indexPath.row];
    cell.text.textColor = self.cellTextColor ? self.cellTextColor : [UIColor whiteColor];
    cell.text.font = self.cellTextSize ? [UIFont systemFontOfSize:self.cellTextSize] : [UIFont systemFontOfSize:16];
    cell.line.backgroundColor = self.cellLineColor ? self.cellLineColor : [UIColor lightGrayColor];
    [cell.errorBtn addTarget:self action:@selector(removeOneClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.errorBtn.tag = indexPath.row;
    return cell;
}

#pragma mark - xx点击事件
- (void)removeOneClick:(UIButton *)btn {

    //删除数组数据
    [self.localArrM removeObjectAtIndex:btn.tag];
    //删除本地数据
    NSMutableArray *temp = [NSMutableArray arrayWithContentsOfFile:FilePaths];
    [temp removeObjectAtIndex:temp.count - btn.tag - 1];
    [temp writeToFile:FilePaths atomically:YES];
    if (self.localArrM.count == 0) {
        [self.tableView removeFromSuperview];
    } else {
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.text = self.localArrM[indexPath.row];
    [self.tableView removeFromSuperview];
    [self resignFirstResponder];
}

#pragma mark - 删除所有数据
- (void)removeAllClick {
    [self.tableView removeFromSuperview];
    [self.localArrM removeAllObjects];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:FilePaths error:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight ? self.cellHeight : 40;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
@end



























