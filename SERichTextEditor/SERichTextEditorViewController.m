//
//  SERichTextEditorViewController.m
//  SERichTextEditor
//
//  Created by wenchang on 2020/11/9.
//  Copyright © 2020 seeEmil. All rights reserved.
//

#import "SERichTextEditorViewController.h"
#import "ASPopover.h"
@interface SERichTextEditorViewController ()

@property (nonatomic, strong) ASPopover *functionPopover;

@property (nonatomic ,strong) NSArray *textFontImgNames;

@property (nonatomic ,strong) UIView *textFontView;
// TODO: 待完成字号气泡、无序列表气泡、颜色气泡
@property (nonatomic ,strong) UIView *fontSizeView;

@property (nonatomic ,strong) UIView *fontSizeNames;

@property (nonatomic ,strong) UIView *alignView;

@property (nonatomic ,strong) UIView *colorView;
@end

@implementation SERichTextEditorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"Custom Buttons";
    
    // HTML Content to set in the editor
    NSString *html = @"This editor is using";
    
    // Set the HTML contents of the editor
    [self setHTML:html];
    
    // Don't allow editor toolbar buttons (you can if you want)
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarNone];
    
    NSArray *imageArr = @[@"undo", @"redo", @"font", @"changeFontSize", @"align", @"sort", @"foreColor"];
    [self addCustomToolbarItemImageNames:imageArr];
}

- (void)didTapCustomToolbarButton:(ZSSBarButtonItem *)item
{
    if ([item.label containsString:@"font"])
    {
        [self.functionPopover show:self.textFontView fromView:[item valueForKey:@"view"]];
    }
    else if ([item.label containsString:@"changeFontSize"])
    {
        [self.functionPopover show:self.textFontView fromView:[item valueForKey:@"view"]];
    }
    else if ([item.label containsString:@"align"])
    {
        [self.functionPopover show:self.alignView fromView:[item valueForKey:@"view"]];
    }
    else
    {
        [self performSelectorWithName:item.label];
    }
}

#pragma mark - Event
- (void)selectStateEvent:(UIButton *)btn
{
    btn.selected = !btn.selected;
    NSString *name = _textFontImgNames[btn.tag - 3650];
    [self resetButtonImage:btn styleImageName:name];
    [self performSelectorWithName:name];
}

- (void)resetButtonImage:(UIButton *)btn styleImageName:(NSString *)styleImageName
{
    NSString *selectImgName = [NSString stringWithFormat:@"%@Selected", styleImageName];
    NSString *btnImgName = btn.isSelected ? selectImgName : styleImageName;
    [btn setImage:[UIImage imageNamed:btnImgName] forState:UIControlStateNormal];
}

- (void)performSelectorWithName:(NSString *)name
{
    SEL selector = NSSelectorFromString(name);
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(self, selector);
}

#pragma mark - LazyLoad
- (ASPopover *)functionPopover {
  if (!_functionPopover) {
    ASPopoverOption *option = [[ASPopoverOption alloc] init];
    option.autoAjustDirection = YES;
    option.preferedType = ASPopoverTypeUp;
    option.arrowSize = CGSizeMake(9, 6);
    option.blackOverlayColor = [UIColor clearColor];
    option.popoverColor = [UIColor whiteColor];
    option.dismissOnBlackOverlayTap = YES;
    option.cornerRadius = 25;
    option.animationIn = 0.2;
    
    _functionPopover = [[ASPopover alloc] initWithOption:option];
  }
  return _functionPopover;
}

- (UIView *)textFontView
{
    if (!_textFontView)
    {
        _textFontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
        for (NSInteger i = 0; i < self.textFontImgNames.count; i ++) {
            UIButton *styleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * 46 + 3.5, 5, 40, 40)];
            NSString *styleImageName = self.textFontImgNames[i];
            [styleBtn setImage:[UIImage imageNamed:styleImageName] forState:UIControlStateNormal];
            styleBtn.tag = 3650 + i;
            [styleBtn addTarget:self action:@selector(selectStateEvent:) forControlEvents:UIControlEventTouchUpInside];
            [_textFontView addSubview:styleBtn];
        }
    }
    return _textFontView;
}

- (NSArray *)textFontImgNames
{
    if (!_textFontImgNames)
    {
        _textFontImgNames = @[@"setBold", @"setItalic", @"setUnderline"];
    }
    return _textFontImgNames;
}

@end
