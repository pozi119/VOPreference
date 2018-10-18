//
//  VOPreferenceCell.h
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VOPreferenceDefs.h"
#import "VPEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface VOPreferenceCell : UITableViewCell
@property (nonatomic, strong) VPEntry *entry;
@property (nonatomic, assign) CGFloat cellHeight;
@end

NS_ASSUME_NONNULL_END
