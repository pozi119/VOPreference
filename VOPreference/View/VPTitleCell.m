//
//  VPTitleCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPTitleCell.h"

@implementation VPTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    self.textLabel.text = entry.title;
    id value = entry.settingValue;
    self.detailTextLabel.text = [NSString stringWithFormat:@"%@",value ? : @""];
}

@end
