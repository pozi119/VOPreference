//
//  VOMultiValController.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPMultiValController.h"
#import "VOPreferenceDefs.h"

@interface VPMultiValController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView  *tableView;
@end

@implementation VPMultiValController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews{
    CGRect rect = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 0.1f)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 50)];
    _tableView.rowHeight = 44;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.entry.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellVal = self.entry.values[indexPath.row];
    static NSString *reuseId = @"VOMuitlValItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.text = indexPath.row < self.entry.titles.count? self.entry.titles[indexPath.row] : @"";
    BOOL checkmarked = [cellVal isEqualToString:[NSString stringWithFormat:@"%@", self.entry.settingValue]];
    cell.accessoryType = checkmarked? UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *cellVal = self.entry.values[indexPath.row];
    [self.entry setSettingValue:cellVal];
    [self.tableView reloadData];
}

@end
