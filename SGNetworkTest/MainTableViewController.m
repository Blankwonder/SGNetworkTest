//
//  MainTableViewController.m
//  Surge-Admin
//
//  Created by Blankwonder on 2021/11/10.
//

#import "MainTableViewController.h"
#import "TestRunningViewController.h"
#import "TestObject.h"

@interface MainTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MainTableViewController {
    NSArray *_cells;
    UITableView *_tableView;
}


- (void)loadView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 1000) style:UITableViewStyleInsetGrouped];
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    self.view = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SGNetworkTest";
    
    KDActionCell *httpDelayTest = [[KDActionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [httpDelayTest setAction:^(KDActionCell *cell, NSIndexPath *indexPath) {
        HTTPDelayTestObject *obj = [[HTTPDelayTestObject alloc] init];
        obj.testURLs = @[@"http://www.baidu.com",
                         @"http://www.qq.com",
                         @"http://www.sina.com.cn",
                         @"http://www.taobao.com",
                         @"http://www.weibo.com"];
        TestRunningViewController *vc = [[TestRunningViewController alloc] initWithTestObj:obj];
        vc.title = cell.textLabel.text;

        [self.navigationController pushViewController:vc animated:YES];
    }];
    httpDelayTest.textLabel.text = @"HTTP Delay Test (China)";
    httpDelayTest.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    KDActionCell *httpsDelayTest = [[KDActionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [httpsDelayTest setAction:^(KDActionCell *cell, NSIndexPath *indexPath) {
        HTTPDelayTestObject *obj = [[HTTPDelayTestObject alloc] init];
        obj.testURLs = @[@"https://www.baidu.com",
                         @"https://www.qq.com",
                         @"https://www.sina.com.cn",
                         @"https://www.taobao.com",
                         @"https://www.weibo.com"];
        TestRunningViewController *vc = [[TestRunningViewController alloc] initWithTestObj:obj];
        vc.title = cell.textLabel.text;

        [self.navigationController pushViewController:vc animated:YES];
    }];
    httpsDelayTest.textLabel.text = @"HTTPS Delay Test (China)";
    httpsDelayTest.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    
    KDActionCell *httpDelayTestGlobal = [[KDActionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [httpDelayTestGlobal setAction:^(KDActionCell *cell, NSIndexPath *indexPath) {
        HTTPDelayTestObject *obj = [[HTTPDelayTestObject alloc] init];
        obj.testURLs = @[@"http://www.cloudflare.com",
                         @"http://www.facebook.com",
                         @"https://www.gstatic.com/generate_204",
                         @"http://www.amazon.com",
                         @"http://www.apple.com"];
        TestRunningViewController *vc = [[TestRunningViewController alloc] initWithTestObj:obj];
        vc.title = cell.textLabel.text;

        [self.navigationController pushViewController:vc animated:YES];
    }];
    httpDelayTestGlobal.textLabel.text = @"HTTP Delay Test (Global)";
    httpDelayTestGlobal.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    KDActionCell *httpsDelayTestGlobal = [[KDActionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    [httpsDelayTestGlobal setAction:^(KDActionCell *cell, NSIndexPath *indexPath) {
        HTTPDelayTestObject *obj = [[HTTPDelayTestObject alloc] init];
        obj.testURLs = @[@"https://www.cloudflare.com",
                         @"https://www.facebook.com",
                         @"https://www.gstatic.com/generate_204",
                         @"https://www.amazon.com",
                         @"https://www.apple.com"];
        TestRunningViewController *vc = [[TestRunningViewController alloc] initWithTestObj:obj];
        vc.title = cell.textLabel.text;

        [self.navigationController pushViewController:vc animated:YES];
    }];
    httpsDelayTestGlobal.textLabel.text = @"HTTPS Delay Test (Global)";
    httpsDelayTestGlobal.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    _cells = @[@[httpDelayTest, httpsDelayTest, httpDelayTestGlobal, httpsDelayTestGlobal]];
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    KDActionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return [cell isKindOfClass:[KDActionCell class]] && cell.action;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    KDActionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[KDActionCell class]]) {
        if (cell.action) {
            cell.action(cell, indexPath);
        }
        return;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_cells[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cells[indexPath.section][indexPath.row];
}


@end


@implementation KDActionCell

@end
