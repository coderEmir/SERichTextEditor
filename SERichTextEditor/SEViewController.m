//
//  SEViewController.m
//  SERichTextEditor
//
//  Created by wenchang on 2020/11/9.
//  Copyright © 2020 seeEmil. All rights reserved.
//

#import "SEViewController.h"
#import "SERichTextEditorViewController.h"
@interface SEViewController ()

@end

@implementation SEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget:self action:@selector(presentView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)presentView {
    SERichTextEditorViewController *cusController = [[SERichTextEditorViewController alloc] init];
    [self.navigationController pushViewController:cusController animated:YES];
}

@end
