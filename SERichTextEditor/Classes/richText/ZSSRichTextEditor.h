//
//  ZSSRichTextEditorViewController.h
//  ZSSRichTextEditor
//
//  Created by Nicholas Hubbard on 11/30/13.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "HRColorPickerViewController.h"
#import "ZSSFontsViewController.h"

/**
 *  The types of toolbar items that can be added
 */
static NSString * _Nullable const ZSSRichTextEditorToolbarBold = @"com.zedsaid.toolbaritem.bold";
static NSString *_Nullable const ZSSRichTextEditorToolbarItalic = @"com.zedsaid.toolbaritem.italic";
static NSString *_Nullable const ZSSRichTextEditorToolbarSubscript = @"com.zedsaid.toolbaritem.subscript";
static NSString *_Nullable const ZSSRichTextEditorToolbarSuperscript = @"com.zedsaid.toolbaritem.superscript";
static NSString *_Nullable const ZSSRichTextEditorToolbarStrikeThrough = @"com.zedsaid.toolbaritem.strikeThrough";
static NSString *_Nullable const ZSSRichTextEditorToolbarUnderline = @"com.zedsaid.toolbaritem.underline";
static NSString *_Nullable const ZSSRichTextEditorToolbarRemoveFormat = @"com.zedsaid.toolbaritem.removeFormat";
static NSString *_Nullable const ZSSRichTextEditorToolbarJustifyLeft = @"com.zedsaid.toolbaritem.justifyLeft";
static NSString *_Nullable const ZSSRichTextEditorToolbarJustifyCenter = @"com.zedsaid.toolbaritem.justifyCenter";
static NSString *_Nullable const ZSSRichTextEditorToolbarJustifyRight = @"com.zedsaid.toolbaritem.justifyRight";
static NSString *_Nullable const ZSSRichTextEditorToolbarJustifyFull = @"com.zedsaid.toolbaritem.justifyFull";
static NSString *_Nullable const ZSSRichTextEditorToolbarH1 = @"com.zedsaid.toolbaritem.h1";
static NSString *_Nullable const ZSSRichTextEditorToolbarH2 = @"com.zedsaid.toolbaritem.h2";
static NSString *_Nullable const ZSSRichTextEditorToolbarH3 = @"com.zedsaid.toolbaritem.h3";
static NSString *_Nullable const ZSSRichTextEditorToolbarH4 = @"com.zedsaid.toolbaritem.h4";
static NSString *_Nullable const ZSSRichTextEditorToolbarH5 = @"com.zedsaid.toolbaritem.h5";
static NSString *_Nullable const ZSSRichTextEditorToolbarH6 = @"com.zedsaid.toolbaritem.h6";
static NSString *_Nullable const ZSSRichTextEditorToolbarTextColor = @"com.zedsaid.toolbaritem.textColor";
static NSString *_Nullable const ZSSRichTextEditorToolbarBackgroundColor = @"com.zedsaid.toolbaritem.backgroundColor";
static NSString *_Nullable const ZSSRichTextEditorToolbarUnorderedList = @"com.zedsaid.toolbaritem.unorderedList";
static NSString *_Nullable const ZSSRichTextEditorToolbarOrderedList = @"com.zedsaid.toolbaritem.orderedList";
static NSString *_Nullable const ZSSRichTextEditorToolbarHorizontalRule = @"com.zedsaid.toolbaritem.horizontalRule";
static NSString *_Nullable const ZSSRichTextEditorToolbarIndent = @"com.zedsaid.toolbaritem.indent";
static NSString *_Nullable const ZSSRichTextEditorToolbarOutdent = @"com.zedsaid.toolbaritem.outdent";
static NSString *_Nullable const ZSSRichTextEditorToolbarInsertImage = @"com.zedsaid.toolbaritem.insertImage";
static NSString *_Nullable const ZSSRichTextEditorToolbarInsertImageFromDevice = @"com.zedsaid.toolbaritem.insertImageFromDevice";
static NSString *_Nullable const ZSSRichTextEditorToolbarInsertLink = @"com.zedsaid.toolbaritem.insertLink";
static NSString *_Nullable const ZSSRichTextEditorToolbarRemoveLink = @"com.zedsaid.toolbaritem.removeLink";
static NSString *_Nullable const ZSSRichTextEditorToolbarQuickLink = @"com.zedsaid.toolbaritem.quickLink";
static NSString *_Nullable const ZSSRichTextEditorToolbarUndo = @"com.zedsaid.toolbaritem.undo";
static NSString *_Nullable const ZSSRichTextEditorToolbarRedo = @"com.zedsaid.toolbaritem.redo";
static NSString *_Nullable const ZSSRichTextEditorToolbarViewSource = @"com.zedsaid.toolbaritem.viewSource";
static NSString *_Nullable const ZSSRichTextEditorToolbarParagraph = @"com.zedsaid.toolbaritem.paragraph";
static NSString *_Nullable const ZSSRichTextEditorToolbarAll = @"com.zedsaid.toolbaritem.all";
static NSString *_Nullable const ZSSRichTextEditorToolbarNone = @"com.zedsaid.toolbaritem.none";
static NSString *_Nullable const ZSSRichTextEditorToolbarFonts = @"com.zedsaid.toolbaritem.fonts";

// source string for parsing JSON
static NSString *_Nullable const ZSSEditorHTML = @"zss_editor.getHTML();";
static NSString *_Nullable const ZSSEditorText = @"zss_editor.getText();";
static NSString *_Nullable const ZSSEditorContent = @"document.activeElement.id=='zss_editor_content'";

typedef void(^CustomButtonEventBlock)(UIBarButtonItem *_Nullable item);
@class ZSSBarButtonItem;

/**
 *  The viewController used with ZSSRichTextEditor
 */
@interface ZSSRichTextEditor : UIViewController <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, HRColorPickerViewControllerDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ZSSFontsViewControllerDelegate>

@property (nonatomic ,copy) CustomButtonEventBlock _Nullable customButtonEventBlock;

/**
 *  The base URL to use for the webView
 */
@property (nonatomic, strong) NSURL *_Nullable baseURL;

/**
 *  If the HTML should be formatted to be pretty
 */
@property (nonatomic) BOOL formatHTML;

/**
 *  If the keyboard should be shown when the editor loads
 */
@property (nonatomic) BOOL shouldShowKeyboard;

/**
 * If the toolbar should always be shown or not
 */
@property (nonatomic, strong, readonly) UIToolbar * _Nonnull toolbar;
@property (nonatomic) BOOL alwaysShowToolbar;

@property (nonatomic) BOOL isScrollToolBar;

/**
 * If the sub class recieves text did change events or not
 */
@property (nonatomic) BOOL receiveEditorDidChangeEvents;

/**
 *  The placeholder text to use if there is no editor content
 */
@property (nonatomic, strong) NSString *_Nullable placeholder;

/**
 *  Toolbar items to include
 */
@property (nonatomic, strong) NSArray *_Nullable enabledToolbarItems;

/**
 *  Color to tint the toolbar items
 */
@property (nonatomic, strong) UIColor *_Nullable toolbarItemTintColor;

/**
 *  Color to tint selected items
 */
@property (nonatomic, strong) UIColor *_Nullable toolbarItemSelectedTintColor;


@property (nonatomic, strong, readonly) WKWebView *_Nullable editorView;
/**
 *  Sets the HTML for the entire editor
 *
 *  @param html  HTML string to set for the editor
 *
 */
- (void)setHTML:(NSString *_Nullable)html;

/**
 *  Returns the HTML from the Rich Text Editor
 *
 */
- (void)getHTML:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

/**
 *  Returns the plain text from the Rich Text Editor
 *
 */
- (void)getText:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;

/**
 *  Inserts HTML at the caret position
 *
 *  @param html  HTML string to insert
 *
 */
- (void)insertHTML:(NSString *_Nullable)html;

/**
 *  Manually focuses on the text editor
 */
- (void)focusTextEditor;

/**
 *  Manually dismisses on the text editor
 */
- (void)blurTextEditor;

/**
 *  Shows the insert image dialog with optinal inputs
 *
 *  @param url The URL for the image
 *  @param alt The alt for the image
 */
- (void)showInsertImageDialogWithLink:(NSString *_Nullable)url alt:(NSString *_Nullable)alt;

/**
 *  Inserts an image
 *
 *  @param url The URL for the image
 *  @param alt The alt attribute for the image
 */
- (void)insertImage:(NSString *_Nullable)url alt:(NSString *_Nullable)alt;

/**
 *  Shows the insert link dialog with optional inputs
 *
 *  @param url   The URL for the link
 *  @param title The tile for the link
 */
- (void)showInsertLinkDialogWithLink:(NSString *_Nullable)url title:(NSString *_Nullable)title;

/**
 *  Inserts a link
 *
 *  @param url The URL for the link
 *  @param title The title for the link
 */
- (void)insertLink:(NSString *_Nullable)url title:(NSString *_Nullable)title;

/**
 *  Gets called when the insert URL picker button is tapped in an alertView
 *
 *  @warning The default implementation of this method is blank and does nothing
 */
- (void)showInsertURLAlternatePicker;

/**
 *  Gets called when the insert Image picker button is tapped in an alertView
 *
 *  @warning The default implementation of this method is blank and does nothing
 */
- (void)showInsertImageAlternatePicker;

/**
 *  Dismisses the current AlertView
 */
- (void)dismissAlertView;

/**
 *  Add a custom UIBarButtonItem by using a UIButton
 */
- (void)addCustomToolbarItemWithButton:(UIButton*_Nullable)button;

/**
 *  Add a custom ZSSBarButtonItem
 */
- (void)addCustomToolbarItemImageNames:(NSArray<NSString *> *_Nullable)item;

/**
 *  Scroll event callback with position
 */
- (void)editorDidScrollWithPosition:(NSInteger)position;

/**
 *  Text change callback with text and html
 */
- (void)editorDidChangeWithText:(NSString *_Nullable)text andHTML:(NSString *_Nonnull)html;

/**
 *  Hashtag callback with word
 */
- (void)hashtagRecognizedWithWord:(NSString *_Nonnull)word;

/**
 *  Mention callback with word
 */
- (void)mentionRecognizedWithWord:(NSString *_Nonnull)word;

/**
 *  Set custom css
 */
- (void)setCSS:(NSString *_Nullable)css;

- (NSString *_Nullable)fileName:(NSString *_Nonnull)fileName;
- (UIImage *_Nullable)imageAtPath:(NSString *_Nonnull)path;

@end
