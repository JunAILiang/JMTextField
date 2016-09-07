//
//  ViewController.m
//  JMTextField
//
//  Created by 刘俊敏 on 16/9/5.
//  Copyright © 2016年 刘俊敏. All rights reserved.
//

#import "ViewController.h"
#import "JMTextField.h"

@interface ViewController ()<JMTextFiledDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JMTextField *tf = [[JMTextField alloc] initWithFrame:CGRectMake(30, 130, 200, 30) InView:self.view];
    tf.delegate = self;
    [self.view addSubview:tf];
}

- (void)returnTextFiledText:(NSString *)text {
    NSLog(@"%@",text);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
