//
//  SERichTextEditorViewController.h
//  SERichTextEditor
//
//  Created by wenchang on 2020/11/9.
//  Copyright © 2020 seeEmil. All rights reserved.
//

#import "SEExport.h"

typedef void(^ContentBlock)(NSString * _Nullable htmlContent, NSString * _Nullable content);

NS_ASSUME_NONNULL_BEGIN

@interface SERichTextEditorViewController : ZSSRichTextEditor

- (void)historyHTMLRecord:(NSString *)htmlText contentBlock:(ContentBlock)contentBlock;

@end

NS_ASSUME_NONNULL_END
