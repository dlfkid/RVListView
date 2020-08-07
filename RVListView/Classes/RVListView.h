//
//  RVListView.h
//  RVListView
//
//  Created by ravendeng on 2020/8/5.
//  Copyright © 2020 ravendeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RVListViewModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^RVOnTapCellBlock) (RVListViewModel *model, NSString *title, NSUInteger index);

@interface RVListView : UIView

/// 直接设置标题数组
@property (nonatomic, strong) NSArray <NSString *> *titles;

/// 直接设置带特征的标题数组
@property (nonatomic, strong) NSArray <NSAttributedString *> *attributedTitles;

/// 以ViewModel形式设置每个Cell的样式
@property (nonatomic, strong) NSArray <RVListViewModel *> *viewModels;

/// 设置每个Cell之间的水平间距
@property (nonatomic, assign) CGFloat cellHorizonalMargin;

/// 设置每个Cell之间的垂直间距, 可以用这个属性决定Cell的行数, 默认0
@property (nonatomic, assign) CGFloat cellVerticalMargin;

/// 点击某个cell的回调
@property (nonatomic, copy) RVOnTapCellBlock tappedCellCallBack;

/// 默认Cell样式
@property (nonatomic, strong, readonly) RVListViewModel *defaultViewModel;

/// 根据模板ViewModel设置标题数组
/// @param titles 标题数组
/// @param model 模板ViewModel
- (void)setTitles:(NSArray <NSString *> *)titles sampleViewModel:(RVListViewModel *)model;


/// 根据模板ViewModel设置标题数组
/// @param attributedTitles 标题数组
/// @param model 模板ViewModel
- (void)setAttributedTitles:(NSArray <NSAttributedString *> *)attributedTitles sampleViewModel:(RVListViewModel *)model;

@end

NS_ASSUME_NONNULL_END
