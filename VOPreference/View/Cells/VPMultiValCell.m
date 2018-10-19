//
//  VPMultiValCell.m
//  Masonry
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPMultiValCell.h"

@implementation VPMultiValCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    NSString *val = [entry settingValue];
    NSArray *values = entry.values;
    NSArray *titles = entry.titles;
    NSInteger idx = [values indexOfObject:val];
    self.textLabel.text = entry.title;
    self.detailTextLabel.text = (idx < titles.count && idx >= 0) ? titles[idx]: @"";
}

@end
