//
//  RVListViewTests.m
//  RVListViewTests
//
//  Created by ravendeng on 08/07/2020.
//  Copyright (c) 2020 ravendeng. All rights reserved.
//

@import XCTest;
#import <RVListView/RVListViewModel.h>

@interface Tests : XCTestCase

@property RVListViewModel *listModel;

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    self.listModel = [[RVListViewModel alloc] init];
}

- (void)tearDown
{
    self.listModel = nil;
    [super tearDown];
}

- (void)testTitleWidth1
{
    CGFloat maxWidth = 120;
    self.listModel.title = @"RVListView";
    self.listModel.maxWidth = maxWidth;
    self.listModel.useFlexibleWidth = NO;
    CGFloat titleWidth = [self.listModel titleWidth];
    XCTAssertTrue(titleWidth == maxWidth, @"Title width is not working as assumed");
}

- (void)testTitleWidth2
{
    CGFloat maxWidth = 300;
    self.listModel.useFlexibleWidth = YES;
    self.listModel.maxWidth = maxWidth;
    self.listModel.title = @"RVListView";
    self.listModel.font = [UIFont boldSystemFontOfSize:18];
    self.listModel.title = @"We are the emperor's chosen.";
    CGSize size = [@"We are the emperor's chosen." sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:18], NSFontAttributeName, nil]];
    int tempTitleWidth = (int)size.width;
    int titleWidth = (int)[self.listModel titleWidth];
    XCTAssertTrue(titleWidth == tempTitleWidth, @"Title width is not working as assumed");
}

- (void)testTitleWidth3
{
    CGFloat maxWidth = 120;
    self.listModel.useFlexibleWidth = YES;
    self.listModel.maxWidth = maxWidth;
    self.listModel.font = [UIFont systemFontOfSize:12];
    NSString *longTItle = @"My preferred option: I ended up putting the Swift Package in an Xcode workspace. By this I mean dragging the root directory containing the Swift Package (and also the Workspace) into the Xcode project navigator/ workspace.";
    self.listModel.title = longTItle;
    CGSize size = [longTItle sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:12], NSFontAttributeName, nil]];
    CGFloat tempTitleWidth = size.width;
    CGFloat titleWidth = [self.listModel titleWidth];
    XCTAssertTrue(titleWidth < tempTitleWidth, @"Title width is not working as assumed");
}

@end

