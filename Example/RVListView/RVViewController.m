//
//  RVViewController.m
//  RVListView
//
//  Created by ravendeng on 08/07/2020.
//  Copyright (c) 2020 ravendeng. All rights reserved.
//

#import "RVViewController.h"

#import <RVListView/RVListView-umbrella.h>

#define kScreenWidth UIScreen.mainScreen.bounds.size.width
#define kScreenHeight UIScreen.mainScreen.bounds.size.height

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface RVViewController ()

@property (nonatomic, strong) RVListView *listView;
@property (nonatomic, strong) UIButton *changeFrameButton;
@property (nonatomic, strong) NSArray <NSString *> *results;

@end

static CGFloat const kViewHeight = 44;

@implementation RVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.results = @[@"Alpha Legion", @"Thousand Sons", @"Death Guard", @"Emperor's Children", @"World Eater", @"Word Bearer", @"Night Lord", @"Iron Worrior", @"Black Legion", @"Ultra Marine", @"Emperial Fist", @"Raven Guard", @"White Scar", @"Blood Angel", @"Dark Angel", @"Space wolf", @"Salamanders", @"Iron Hands"];
    
    _listView = [[RVListView alloc] initWithFrame:CGRectMake(0, (kScreenHeight - kViewHeight) / 2, kScreenWidth, kViewHeight)];
    self.listView.backgroundColor = [UIColor yellowColor];
    self.listView.tappedCellCallBack = ^(RVListViewModel * _Nonnull model, NSString * _Nonnull title, NSUInteger index) {
        NSLog(@"点击了话题: %@", title);
    };
    
    [self.view addSubview:self.listView];
    self.listView.cellHorizonalMargin = 10;
    _changeFrameButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_changeFrameButton setTitle:@"Load Data" forState:UIControlStateNormal];
    _changeFrameButton.frame = CGRectMake((kScreenWidth - 100) /2, kScreenHeight - 80, 100, 44);
    [_changeFrameButton addTarget:self action:@selector(onClickChangeFrameButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeFrameButton];
}

- (void)onClickChangeFrameButton:(UIButton *)sender {
    
    self.listView.defaultViewModel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.listView.defaultViewModel.maxWidth = 180;
    self.listView.titles = self.results;
    
    NSMutableArray *viewModels = [[NSMutableArray <RVListViewModel *> alloc] init];

    for (NSString *title in self.results) {
        RVListViewModel *model = [[RVListViewModel alloc] init];
        model.title = title;
        model.leftIconImage = [UIImage imageNamed:@"Close"];
        model.leftIconSize = CGSizeMake(20, 20);
        model.textColor = randomColor;
        model.backgroundColor = randomColor;
        model.maxWidth = 150;
        [viewModels addObject:model];
    }

    self.listView.viewModels = viewModels;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
