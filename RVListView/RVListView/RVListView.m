//
//  RVListView.m
//  RVListView
//
//  Created by ravendeng on 2020/8/5.
//  Copyright © 2020 ravendeng. All rights reserved.
//

#import "RVListView.h"

#import "RVListViewModel.h"

#import "RVListCollectionViewCell.h"

@interface RVListView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RVListViewModel *defaultViewModel;

@end

@implementation RVListView

#pragma mark - Override

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configCollectionView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configCollectionView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configCollectionView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.collectionView.frame = self.bounds;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    NSMutableArray *viewModelsArray = [NSMutableArray array];
    
    for (NSString *title in self.titles) {
        RVListViewModel *viewModel = [self.defaultViewModel copy];
        viewModel.title = title;
        [viewModelsArray addObject:viewModel];
    }
    
    _viewModels = viewModelsArray;
    
    [self.collectionView reloadData];
}

- (void)setAttributedTitles:(NSArray<NSAttributedString *> *)attributesTitles {
    _attributedTitles = attributesTitles;
    
    NSMutableArray *viewModelsArray = [NSMutableArray array];
    
    for (NSAttributedString *attributeTitle in self.titles) {
        RVListViewModel *viewModel = [self.defaultViewModel copy];
        viewModel.attributeTitle = attributeTitle;
        [viewModelsArray addObject:viewModel];
    }
    
    _viewModels = viewModelsArray;
    
    [self.collectionView reloadData];
}

- (void)setViewModels:(NSArray<RVListViewModel *> *)viewModels {
    _viewModels = viewModels;
    
    [self.collectionView reloadData];
}

- (void)setCellHorizonalMargin:(CGFloat)cellMargin {
    _cellHorizonalMargin = cellMargin;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = cellMargin;
    [self.collectionView reloadData];
}

#pragma mark - Public

- (void)setTitles:(NSArray<NSString *> *)titles sampleViewModel:(RVListViewModel *)model {
    _titles = titles;
    
    NSMutableArray *viewModelsArray = [NSMutableArray array];
    
    for (NSString *title in self.titles) {
        RVListViewModel *viewModel = [model copy];
        viewModel.title = title;
        [viewModelsArray addObject:viewModel];
    }
    
    _viewModels = viewModelsArray;
    
    [self.collectionView reloadData];
}

- (void)setAttributedTitles:(NSArray<NSAttributedString *> *)attributedTitles sampleViewModel:(RVListViewModel *)model {
    _attributedTitles = attributedTitles;
    NSMutableArray *viewModelsArray = [NSMutableArray array];
    
    for (NSAttributedString *attributedTitle in self.attributedTitles) {
        RVListViewModel *viewModel = [model copy];
        viewModel.attributeTitle = attributedTitle;
        [viewModelsArray addObject:viewModel];
    }
    
    _viewModels = viewModelsArray;
    
    [self.collectionView reloadData];
}

#pragma mark - Private

- (void)configCollectionView {
    self.cellHorizonalMargin = 10;
    self.cellVerticalMargin = 0;
    [self addSubview:self.collectionView];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumInteritemSpacing = 10;

    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[RVListCollectionViewCell class] forCellWithReuseIdentifier:[RVListCollectionViewCell reuseIdentifier]];
    [self addSubview:self.collectionView];
}

#pragma mark - UIColectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = self.viewModels.count;
    return count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RVListCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:[RVListCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    RVListViewModel *model = self.viewModels[indexPath.item];
    cell.viewModel = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.item;
    RVListViewModel *viewModel = self.viewModels[index];
    !self.tappedCellCallBack ?: self.tappedCellCallBack(viewModel, viewModel.title, index);
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    RVListViewModel *model = self.viewModels[indexPath.item];
    CGFloat leftMargin = 0;
    CGFloat rightMargin = 0;
    if (model.leftIconImage) {
        leftMargin = model.leftIconMargin + model.leftIconSize.width;
    }
    if (model.rightIconImage) {
        rightMargin = model.rightIconMargin + model.rightIconSize.width;
    }
    return CGSizeMake(model.titleWidth + model.radius * 2 + leftMargin + rightMargin, model.cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(self.cellVerticalMargin, self.cellHorizonalMargin, self.cellVerticalMargin, self.cellHorizonalMargin);
}

#pragma mark - Getter

- (RVListViewModel *)defaultViewModel {
    if (!_defaultViewModel) {
        _defaultViewModel = [[RVListViewModel alloc] init];
        _defaultViewModel.maxWidth = 110;
        _defaultViewModel.cellHeight = 24;
        _defaultViewModel.radius = _defaultViewModel.cellHeight / 2;
        _defaultViewModel.backgroundColor = [UIColor lightGrayColor];
        _defaultViewModel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _defaultViewModel;;
}

@end
