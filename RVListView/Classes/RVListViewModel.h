//
//  RVListViewModel.h
//  RVListView
//
//  Created by ravendeng on 2020/8/5.
//  Copyright © 2020 ravendeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RVListViewModel : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;

/// 特征标题
@property (nullable, nonatomic, copy) NSAttributedString *attributeTitle;

/// 字体
@property (nonatomic, strong) UIFont *font;

/// 字体颜色
@property (nonatomic, strong) UIColor *textColor;

/// 背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;

/// 每个Label的最大宽度
@property (nonatomic, assign) CGFloat maxWidth;

/// 每个Cell的最大高度
@property (nonatomic, assign) CGFloat cellHeight;

/// 圆角半径
@property (nonatomic, assign) CGFloat radius;

/// 左图标
@property (nullable, nonatomic, strong) UIImage *leftIconImage;

/// 左图标大小
@property (nonatomic, assign) CGSize leftIconSize;

/// 标签和左图标的间距
@property (nonatomic, assign) CGFloat leftIconMargin;

/// 右图标
@property (nullable, nonatomic, strong) UIImage *rightIconImage;

/// 右图标大小
@property (nonatomic, assign) CGSize rightIconSize;

/// 右图标和标签的间距
@property (nonatomic, assign) CGFloat rightIconMargin;

/// 获取标题在当前字体下的宽度
@property (nonatomic, assign, readonly) CGFloat titleWidth;

/// 是否使用弹性宽度
@property (nonatomic, assign) BOOL useFlexibleWidth;

@end

NS_ASSUME_NONNULL_END
