# RVListView

A flexible collection view to show some data

[![CI Status](https://img.shields.io/travis/ravendeng/RVListView.svg?style=flat)](https://travis-ci.org/ravendeng/RVListView)
[![Version](https://img.shields.io/cocoapods/v/RVListView.svg?style=flat)](https://cocoapods.org/pods/RVListView)
[![License](https://img.shields.io/cocoapods/l/RVListView.svg?style=flat)](https://cocoapods.org/pods/RVListView)
[![Platform](https://img.shields.io/cocoapods/p/RVListView.svg?style=flat)](https://cocoapods.org/pods/RVListView)

## Requirements

````
iOS 9.0
````

## Installation

RVListView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RVListView'
```

## Feature

1. **Flexible width for earch Cell**

![pic1](/Users/ravendeng/Documents/Projects/RVListView/Pics/pic1.png)

2. **Support Left or right image icon**

![pic2](/Users/ravendeng/Documents/Projects/RVListView/Pics/pic2.png)

3. **Unique properties for each cell**

![pic3](/Users/ravendeng/Documents/Projects/RVListView/Pics/pic3.png)

## Usage

1. **Initalize** RVListView as any other common views:

````objc
self.listView = [[RVListView alloc] initWithFrame:CGRectMake(0, (kScreenHeight - kViewHeight) / 2, kScreenWidth, kViewHeight)];
````

2. **Set titles** for cells with default configuration:

````objc
self.results = @[@"Alpha Legion", @"Thousand Sons", @"Death Guard", @"Emperor's Children", @"World Eater", @"Word Bearer", @"Night Lord", @"Iron Worrior", @"Black Legion", @"Ultra Marine", @"Emperial Fist", @"Raven Guard", @"White Scar", @"Blood Angel", @"Dark Angel", @"Space wolf", @"Salamanders", @"Iron Hands"];

self.listView.titles = self.results;
````

3. **Change default** cell configuration:

````objc
self.listView.defaultViewModel.cellHeight = 44;
````

4. **Set uinique** config for each cell:

````objc
NSMutableArray *viewModels = [[NSMutableArray <RVListViewModel *> alloc] init];
    
for (NSString *title in self.results) {
    RVListViewModel *model = [[RVListViewModel alloc] init];
    model.title = title;
    model.leftIconImage = [UIImage imageNamed:@"关闭"];
    model.leftIconSize = CGSizeMake(20, 20);
    model.rightIconImage = [UIImage imageNamed:@"关闭"];
    model.rightIconSize = CGSizeMake(20, 20);
    model.textColor = [UIColor redColor];
    model.backGroundColor = randomColor;
    model.maxWidth = 150;
    [viewModels addObject:model];
}
    
self.listView.viewModels = viewModels;
````

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Change Log

### V1.0.1

Initial upload.

## Author

[RavenDeng](dlfkid@icloud.com)

## License

RVListView is available under the MIT license. See the LICENSE file for more info.
