//
//  VOPreferenceController.h
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPSetting.h"

@interface VOPreferenceController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) VPSetting *setting;
@property (nonatomic, strong, readonly) UITableView *tableView;
@end
