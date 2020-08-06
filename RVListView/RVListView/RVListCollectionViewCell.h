//
//  RVListCollectionViewCell.h
//  RVListView
//
//  Created by ravendeng on 2020/8/5.
//  Copyright © 2020 ravendeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RVListViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface RVListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong) RVListViewModel *viewModel;

+ (NSString *)reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
