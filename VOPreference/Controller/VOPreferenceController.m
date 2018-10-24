//
//  VOPreferenceController.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VOPreferenceController.h"
#import "VPSetting.h"
#import "VPTitleCell.h"
#import "VPMultiValCell.h"
#import "VPTextFieldCell.h"
#import "VPSwitchCell.h"
#import "VPSliderCell.h"
#import "VPButtonCell.h"
#import "VPSegmentedSliderCell.h"
#import "VPMultiValController.h"

@interface VOPreferenceController ()
@property (nonatomic, strong) NSArray *groupedEntries;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation VOPreferenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:VOPreferenceDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * note) {
        VPEntry *entry = note.object;
        if(entry.relativeIndexPaths.count == 0) return;
        [self.tableView reloadRowsAtIndexPaths:entry.relativeIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)setSetting:(VPSetting *)setting{
    _setting = setting;
    self.groupedEntries = setting.groupedEntires;
}

- (void)setGroupedEntries:(NSArray *)groupedEntries{
    _groupedEntries = groupedEntries;
    [self registerCustomClassesForTableView];
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        CGRect rect = self.view.bounds;
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 0.1f)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 50)];
        _tableView.sectionFooterHeight = 0;
        _tableView.rowHeight = 44;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)registerCustomClassesForTableView{
    [self.tableView registerClass:VPTitleCell.class forCellReuseIdentifier:NSStringFromClass(VPTitleCell.class)];
    for (VPEntryGroup *group in self.groupedEntries) {
        for (VPEntry *entry in group.entries) {
            if(entry.cellClass.length > 0){
                Class cellClass = NSClassFromString(entry.cellClass);
                if(cellClass && [cellClass isSubclassOfClass:VOPreferenceCell.class]){
                    [self.tableView registerClass:cellClass forCellReuseIdentifier:entry.cellClass];
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupedEntries.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    VPEntryGroup *group = self.groupedEntries[section];
    return group.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VPEntryGroup *group = self.groupedEntries[indexPath.section];
    VPEntry *entry = group.entries[indexPath.row];
    NSString *reuseId = entry.cellClass;
    VOPreferenceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    NSAssert(cell != nil, @"`dequeueReusableCellWithIdentifier`失败,请检查配置文件");
    cell.entry = entry;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VPEntryGroup *group = self.groupedEntries[indexPath.section];
    VPEntry *entry = group.entries[indexPath.row];
    NSString *toggleKey = entry.toggleKey;
    BOOL hidden = (toggleKey.length > 0 && [self.setting.keyValues[toggleKey] integerValue] == 0);
    Class cellClass = NSClassFromString(entry.cellClass);
    if(hidden || ![cellClass isSubclassOfClass:VOPreferenceCell.class]) return 0;
    return [cellClass height:entry.spread];
}

- (CGFloat)heightForHeaderFooterText:(NSString *)text fontSize:(CGFloat)fontSize{
    CGFloat height = 10;
    if(text.length > 0){
        CGFloat width = self.tableView.bounds.size.width - 40;
        UIFont *font = [UIFont systemFontOfSize:fontSize];
        NSDictionary *attrs = @{NSFontAttributeName: font};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attrs
                                         context:nil];
        height = rect.size.height + 20;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    VPEntryGroup *group = self.groupedEntries[section];
    return [self heightForHeaderFooterText:group.header.title fontSize:16];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    VPEntryGroup *group = self.groupedEntries[section];
    return [self heightForHeaderFooterText:group.footer.title fontSize:14];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VPEntryGroup *group = self.groupedEntries[indexPath.section];
    VPEntry *entry = group.entries[indexPath.row];
    if(entry.selectionHandler) {
        entry.selectionHandler(entry);
    }
    else{
        if (entry.type != VPEntryTypeMultiVal) { return; }
        VPMultiValController *multivalVC = [VPMultiValController new];
        multivalVC.entry = entry;
        [self.navigationController pushViewController:multivalVC animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    VPEntryGroup *group = self.groupedEntries[section];
    return group.header.title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    VPEntryGroup *group = self.groupedEntries[section];
    return group.footer.title;
}

@end
