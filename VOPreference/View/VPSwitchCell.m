//
//  VPSwitchCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPSwitchCell.h"

@interface VPSwitchCell ()
@property (nonatomic, strong) UISwitch *xswitch;
@end

@implementation VPSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _xswitch = [UISwitch new];
    [_xswitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = _xswitch;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    id val = [entry settingValue];
    BOOL on = [val boolValue];
    self.textLabel.text = entry.title;
    _xswitch.on = on;
}

- (void)switchValueChanged:(UISwitch *)sender{
    NSNumber *val = @(sender.on);
    [self.entry setSettingValue:val];
}

@end
