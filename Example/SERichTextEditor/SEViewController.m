//
//  SEViewController.m
//  SERichTextEditor
//
//  Created by 17629918 on 12/06/2020.
//  Copyright (c) 2020 17629918. All rights reserved.
//

#import "SEViewController.h"
#import "SERichTextEditorViewController.h"
@interface SEViewController ()

@end

@implementation SEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn addTarget:self action:@selector(presentView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


- (void)presentView {
    
    SERichTextEditorViewController *controller = [[SERichTextEditorViewController alloc] init];
    __weak typeof(controller) weakController = controller;
    [controller historyHTMLRecord:@"测试文本" contentBlock:^(NSString * _Nullable htmlContent) {
        NSLog(@"%@---htmlContent",htmlContent);
        [weakController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:navController animated:YES completion:nil];
}

@end
