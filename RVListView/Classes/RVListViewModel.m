//
//  RVListViewModel.m
//  RVListView
//
//  Created by ravendeng on 2020/8/5.
//  Copyright © 2020 ravendeng. All rights reserved.
//

#import "RVListViewModel.h"

@interface RVListViewModel() <NSCopying>

@end

@implementation RVListViewModel

- (instancetype)init {
    if (self = [super init]) {
        _font = [UIFont systemFontOfSize:14];
        _textColor = [UIColor blackColor];
        _maxWidth = 200;
        _cellHeight = 32;
        _radius = 16;
        _leftIconSize = CGSizeZero;
        _rightIconSize = CGSizeZero;
        _leftIconMargin = 10;
        _rightIconMargin = 10;
        _useFlexibleWidth = YES;
    }
    return self;
}

- (CGFloat)titleWidth {
    if (self.useFlexibleWidth) {
        CGSize size = [self.title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil]];
        CGFloat tempTitleWidth = size.width;
        if (tempTitleWidth >= self.maxWidth) {
            tempTitleWidth = self.maxWidth;
        }
        return tempTitleWidth;
    } else {
        return self.maxWidth;
    }
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    RVListViewModel *model = [[RVListViewModel alloc] init];
    model.title = self.title;
    model.attributeTitle = self.attributeTitle;
    model.backgroundColor = self.backgroundColor;
    model.textColor = self.textColor;
    model.cellHeight = self.cellHeight;
    model.font = self.font;
    model.maxWidth = self.maxWidth;
    model.radius = self.radius;
    model.leftIconImage = self.leftIconImage;
    model.rightIconImage = self.rightIconImage;
    model.leftIconSize = self.leftIconSize;
    model.rightIconSize = self.rightIconSize;
    model.leftIconMargin = self.leftIconMargin;
    model.rightIconMargin = self.rightIconMargin;
    return model;
}

@end
