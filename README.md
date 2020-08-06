# RVListView
A flexible collection view to show some data



# update Log

## V1.0.0

Initial upload.



# Feature

1. **Flexible width for earch Cell**

![pic1](Pics/pic1.png)

2. **Support Left or right image icon**

![pic2](Pics/pic2.png)

3. **Unique properties for each cell**

![pic3](Pics/pic3.png)



# install 

## CocoaPods

Configure your pod file as follow:

````ruby
pod `RVListView`, :git => https://github.com/dlfkid/RVListView.git, :tag => "1.0.0"
````

Run command in your command line:

````
pod install
````

## Source

Just drag anything you need in to your project.



# Usage

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



# Lisence

RVList View is released under the MIT License. See [LICENSE](LICENSE) for details.

