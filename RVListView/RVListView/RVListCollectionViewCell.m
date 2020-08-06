//
//  RVListCollectionViewCell.m
//  RVListView
//
//  Created by ravendeng on 2020/8/5.
//  Copyright © 2020 ravendeng. All rights reserved.
//

#import "RVListCollectionViewCell.h"

#import "RVListViewModel.h"

@interface RVListCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *leftIcon;
@property (nonatomic, strong) UIImageView *rightIcon;

@end

@implementation RVListCollectionViewCell

#pragma mark - Overide

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureBaseUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureBaseUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configureBaseUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self relayoutSubViews];
}

- (void)setViewModel:(RVListViewModel *)viewModel {
    _viewModel = viewModel;
    self.titleLabel.text = viewModel.title;
    if (viewModel.attributeTitle) {
       self.titleLabel.attributedText = viewModel.attributeTitle;
    }
    self.titleLabel.font = viewModel.font;
    self.titleLabel.textColor = viewModel.textColor;
    self.bottomView.backgroundColor = viewModel.backgroundColor;
    if (viewModel.leftIconImage) {
        self.leftIcon.image = viewModel.leftIconImage;
    }
    if (viewModel.rightIconImage) {
        self.rightIcon.image = viewModel.rightIconImage;
    }
    self.leftIcon.image = viewModel.leftIconImage;
    self.rightIcon.image = viewModel.rightIconImage;
}

#pragma mark - Private

- (void)configureBaseUI {
    _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    _leftIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    _rightIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.leftIcon];
    [self.contentView addSubview:self.rightIcon];
}

- (void)relayoutSubViews {
    CGFloat viewHeight = CGRectGetHeight(self.contentView.bounds);
    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
    
    self.bottomView.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    self.bottomView.layer.cornerRadius = self.viewModel.radius;
    
    CGFloat leftMargin = self.viewModel.radius;
    // 布局左图标
    if (self.viewModel.leftIconImage) {
        CGFloat imageY = (viewHeight - self.viewModel.leftIconSize.height) / 2;
        self.leftIcon.frame = CGRectMake(self.viewModel.radius, imageY, self.viewModel.leftIconSize.width, self.viewModel.leftIconSize.height);
        leftMargin = self.viewModel.radius + self.viewModel.leftIconMargin + self.viewModel.leftIconSize.width;
    }
    // 布局Label
    self.titleLabel.frame = CGRectMake(leftMargin, 0, self.viewModel.titleWidth, viewHeight);
    // 布局右图标
    if (self.viewModel.rightIconImage) {
        CGFloat imageY = (viewHeight - self.viewModel.rightIconSize.height) / 2;
        CGFloat rightMargin = CGRectGetMaxX(self.titleLabel.frame) + self.viewModel.rightIconMargin;
        self.rightIcon.frame = CGRectMake(rightMargin, imageY, self.viewModel.rightIconSize.width, self.viewModel.rightIconSize.height);
    }
    
}

#pragma mark - Public

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
