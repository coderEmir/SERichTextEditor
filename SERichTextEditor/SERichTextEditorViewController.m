//
//  SERichTextEditorViewController.m
//  SERichTextEditor
//
//  Created by wenchang on 2020/11/9.
//  Copyright © 2020 seeEmil. All rights reserved.
//

#import "SERichTextEditorViewController.h"
#import "ASPopover.h"

static NSInteger const FontTag = 3650;
static NSInteger const FontSizeTag = 3750;
static NSInteger const AlignTag = 3850;
static NSInteger const SortTag = 3950;
static NSInteger const ColorTag = 4050;

@interface SERichTextEditorViewController ()

@property (nonatomic, strong) ASPopover *functionPopover;

@property (nonatomic ,strong) NSArray *textFontImgNames;

@property (nonatomic ,strong) UIView *textFontView;

// 字号气泡
@property (nonatomic ,strong) UIView *fontSizeView;
@property (nonatomic ,strong) NSArray *fontSizeImgNames;
@property (nonatomic ,strong) UIButton *oldFontSizeBtn;

// 对齐方式气泡
@property (nonatomic ,strong) UIView *alignView;
@property (nonatomic ,strong) NSArray *alignImgNames;
@property (nonatomic ,strong) UIButton *oldAlignBtn;

// 排序气泡
@property (nonatomic ,strong) UIView *sortView;
@property (nonatomic ,strong) NSArray *sortImgNames;
@property (nonatomic ,strong) UIButton *oldSortBtn;

// 颜色气泡
@property (nonatomic ,strong) UIView *colorView;
@property (nonatomic ,strong) NSArray *colorImgNames;
@property (nonatomic ,strong) UIButton *oldColorBtn;

@property (nonatomic ,copy) NSString *currentTextState;

@end

@implementation SERichTextEditorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *html = @"Just to test the text editing function";
    [self setHTML:html];
    self.enabledToolbarItems = @[ZSSRichTextEditorToolbarNone];
    
    NSArray *imageArr = @[@"undo", @"redo", @"font", @"changeFontSize", @"align", @"sort", @"foreColor"];
    [self addCustomToolbarItemImageNames:imageArr];
}

- (void)didTapCustomToolbarButton:(ZSSBarButtonItem *)item
{
    if ([item.label containsString:@"font"])
    {
        [self resetFont:0 hadFont:[self.currentTextState containsString:@"bold"]];
        [self resetFont:1 hadFont:[self.currentTextState containsString:@"italic"]];
        [self resetFont:2 hadFont:[self.currentTextState containsString:@"underline"]];
        [self.functionPopover show:self.textFontView fromView:[item valueForKey:@"view"]];
    }
    else if ([item.label containsString:@"changeFontSize"])
    {
        [self.functionPopover show:self.fontSizeView fromView:[item valueForKey:@"view"]];
    }
    else if ([item.label containsString:@"align"])
    {
        [self.functionPopover show:self.alignView fromView:[item valueForKey:@"view"]];
    }
    else if ([item.label containsString:@"sort"])
    {
        [self.functionPopover show:self.sortView fromView:[item valueForKey:@"view"]];
    }
    else if ([item.label containsString:@"foreColor"])
    {
        [self.functionPopover show:self.colorView fromView:[item valueForKey:@"view"]];
    }
    else
    {
        [self performSelectorWithName:item.label];
    }
}

#pragma mark - Event
- (void)textFontEvent:(UIButton *)btn
{
    
    btn.selected = !btn.selected;
    NSString *name = _textFontImgNames[btn.tag - FontTag];
    [self resetButtonImage:btn styleImageName:name];
    [self performSelectorWithName:name];
}

- (void)fontSizeEvent:(UIButton *)btn
{
    NSArray *eventInfos = [self singleSelectEventInNewBtn:btn oldBtn:self.oldFontSizeBtn tag:FontSizeTag imageNames:self.fontSizeImgNames];
    self.oldFontSizeBtn = eventInfos.lastObject;
    [self performSelectorWithName:eventInfos.firstObject];
}

- (void)alignEvent:(UIButton *)btn
{
    NSArray *eventInfos = [self singleSelectEventInNewBtn:btn oldBtn:self.oldAlignBtn tag:AlignTag imageNames:self.alignImgNames];
    self.oldAlignBtn = eventInfos.lastObject;
    [self performSelectorWithName:eventInfos.firstObject];
}

- (void)sortEvent:(UIButton *)btn
{
    UIButton *oldBtn = nil;
    if (self.oldSortBtn && self.oldSortBtn != btn) {
        oldBtn = self.oldSortBtn;
    }
    NSArray *eventInfos = [self singleSelectEventInNewBtn:btn oldBtn:oldBtn tag:SortTag imageNames:self.sortImgNames];
    self.oldSortBtn = eventInfos.lastObject;
    [self performSelectorWithName:eventInfos.firstObject];
}

- (void)colorEvent:(UIButton *)btn
{
    NSArray *eventInfos = [self singleSelectEventInNewBtn:btn oldBtn:self.oldColorBtn tag:ColorTag imageNames:self.colorImgNames];
    self.oldColorBtn = eventInfos.lastObject;
    [self setSelectedColorStr:eventInfos.firstObject tag:1];
}

- (NSArray *)singleSelectEventInNewBtn:(UIButton *)btn oldBtn:(UIButton *)oldBtn tag:(NSInteger)tag imageNames:(NSArray *)imageNames
{
    if (oldBtn)
    {
        oldBtn.selected = NO;
        [oldBtn setImage:[UIImage imageNamed:imageNames[oldBtn.tag - tag]] forState:UIControlStateNormal];
    }
    btn.selected = !btn.selected;
    NSString *name = imageNames[btn.tag - tag];
    [self resetButtonImage:btn styleImageName:name];
    return @[name, btn];
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

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    [super webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    self.currentTextState = [navigationAction.request.URL absoluteString];
}

- (void)resetFont:(NSInteger)index hadFont:(BOOL)hadFont
{
    UIButton *btn = self.textFontView.subviews[index];
    NSString *selectImgName = [self.textFontImgNames[index] stringByAppendingString:@"Selected"];
    NSString *imgName = hadFont ? selectImgName : self.textFontImgNames[index];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    btn.selected = hadFont;
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
// 字体
- (UIView *)textFontView
{
    if (!_textFontView)
    {
        _textFontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
        [self addSubFunctionButton:self.textFontImgNames selector:@selector(textFontEvent:) tag:FontTag toView:_textFontView];
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

//  字号
- (UIView *)fontSizeView
{
    if (!_fontSizeView)
    {
        _fontSizeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
        [self addSubFunctionButton:self.fontSizeImgNames selector:@selector(fontSizeEvent:) tag:FontSizeTag toView:_fontSizeView];
        UIButton *btn = _fontSizeView.subviews[1];
        [btn setImage:[UIImage imageNamed:@"fontSizeNomalSelected"] forState:UIControlStateNormal];
        btn.selected = YES;
        self.oldFontSizeBtn = btn;
    }
    return _fontSizeView;
}

- (NSArray *)fontSizeImgNames
{
    if (!_fontSizeImgNames)
    {
        _fontSizeImgNames = @[@"fontSizeSmall",@"fontSizeNomal",@"fontSizeLarge"];
    }
    return _fontSizeImgNames;
}

// 对齐方式气泡
- (UIView *)alignView
{
    if (!_alignView)
    {
        _alignView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
        [self addSubFunctionButton:self.alignImgNames selector:@selector(alignEvent:) tag:AlignTag toView:_alignView];
    }
    return _alignView;
}

- (NSArray *)alignImgNames
{
    if (!_alignImgNames)
    {
        _alignImgNames = @[@"alignLeft" ,@"alignCenter" ,@"alignRight"];
    }
    return _alignImgNames;
}


// 排序气泡
- (UIView *)sortView
{
    if (!_sortView)
    {
        _sortView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 96, 50)];
        [self addSubFunctionButton:self.sortImgNames selector:@selector(sortEvent:) tag:SortTag toView:_sortView];
    }
    return _sortView;
}

- (NSArray *)sortImgNames
{
    if (!_sortImgNames)
    {
        _sortImgNames = @[@"setUnorderedList" ,@"setOrderedList"];
    }
    return _sortImgNames;
}
//// 颜色气泡
- (UIView *)colorView
{
    if (!_colorView)
    {
        _colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 234, 50)];
        [self addSubFunctionButton:self.colorImgNames selector:@selector(colorEvent:) tag:ColorTag toView:_colorView];
    }
    return _colorView;
}

- (NSArray *)colorImgNames
{
    if (!_colorImgNames)
    {
        _colorImgNames = @[@"252120" ,@"817f80" ,@"ff5353" ,@"eea849" ,@"45c3e9" ,@"4caf50"];
    }
    return _colorImgNames;
}

- (void)addSubFunctionButton:(NSArray *)imgNames selector:(SEL)action tag:(NSInteger)tag toView:(UIView *)superView
{
    for (NSInteger i = 0; i < imgNames.count; i ++) {
        UIButton *styleBtn = [[UIButton alloc] initWithFrame:CGRectMake(i * 46 + 3.5, 5, 40, 40)];
        NSString *imageName = imgNames[i];
        [styleBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        styleBtn.tag = tag + i;
        [styleBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        [superView addSubview:styleBtn];
    }
}

@end
