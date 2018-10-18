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
    [self setupSubviews];
    [[NSNotificationCenter defaultCenter] addObserverForName:VOPreferenceDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * note) {
        [self.tableView reloadData];
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

- (void)setupSubviews{
    CGRect rect = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 0.1f)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 50)];
    _tableView.sectionFooterHeight = 0;
    _tableView.rowHeight = 44;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self registerBuiltInClassesForTableView];
    [self.view addSubview:_tableView];
}

- (void)registerBuiltInClassesForTableView{
    [_tableView registerClass:[VPTitleCell class] forCellReuseIdentifier:VPType_Title];
    [_tableView registerClass:[VPMultiValCell class] forCellReuseIdentifier:VPType_MulitVal];
    [_tableView registerClass:[VPTextFieldCell class] forCellReuseIdentifier:VPType_TextField];
    [_tableView registerClass:[VPSwitchCell class] forCellReuseIdentifier:VPType_Switch];
    [_tableView registerClass:[VPSliderCell class] forCellReuseIdentifier:VPType_Slider];
    [_tableView registerClass:[VPButtonCell class] forCellReuseIdentifier:VPType_Button];
    [_tableView registerClass:[VPSegmentedSliderCell class] forCellReuseIdentifier:VPType_SegmentedSlider];
}

- (void)registerCustomClassesForTableView{
    for (VPEntryGroup *group in self.groupedEntries) {
        for (VPEntry *entry in group.entries) {
            if(entry.type == VPEntryTypeCustom && entry.customCell.length > 0 && entry.typeString.length > 0){
                Class cellClass = NSClassFromString(entry.customCell);
                if(cellClass && [cellClass isKindOfClass:VOPreferenceCell.class]){
                    [_tableView registerClass:cellClass forCellReuseIdentifier:entry.typeString];
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
    BOOL classValid = YES;
    if(entry.type == VPEntryTypeCustom){
        Class cellClass = NSClassFromString(entry.customCell);
        classValid = cellClass && [cellClass isKindOfClass:VOPreferenceCell.class];
    }
    NSString *reuseId = (classValid && entry.typeString.length > 0) ? entry.typeString : VPType_Title;
    VOPreferenceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.entry = entry;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VOPreferenceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return cell ? cell.cellHeight : 44;
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
    BOOL canSelect = entry.type == VPEntryTypeMultiVal;
    if (!canSelect) { return; }
    VPMultiValController *multivalVC = [VPMultiValController new];
    multivalVC.entry = entry;
    [self.navigationController pushViewController:multivalVC animated:YES];
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
