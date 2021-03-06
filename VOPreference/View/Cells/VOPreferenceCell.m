//
//  VOPreferenceCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VOPreferenceCell.h"

@implementation VOPreferenceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds  = YES;
    }
    return self;
}

- (void)setEntry:(VPEntry *)entry{
    _entry = entry;
    if(entry.selectionHandler){
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    }
}

+ (CGFloat)height:(BOOL)spread{
    return 44.0f;
}

@end
