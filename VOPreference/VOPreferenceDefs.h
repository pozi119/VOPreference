//
//  VOPreferenceDefs.h
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPEntry.h"

//MARK: - 通知
FOUNDATION_EXPORT NSString *const VOPreferenceDidChangeNotification;

//MARK: - 配置项类型 [兼容iOS Setting.bundle]
FOUNDATION_EXPORT NSString *const VPType_Group;
FOUNDATION_EXPORT NSString *const VPType_Title;
FOUNDATION_EXPORT NSString *const VPType_MulitVal;
FOUNDATION_EXPORT NSString *const VPType_TextField;
FOUNDATION_EXPORT NSString *const VPType_Switch;
FOUNDATION_EXPORT NSString *const VPType_Slider;

//MARK: [自定义]
FOUNDATION_EXPORT NSString *const VPType_Button;
FOUNDATION_EXPORT NSString *const VPType_Custom;
FOUNDATION_EXPORT NSString *const VPType_GroupFooter;
FOUNDATION_EXPORT NSString *const VPType_SegmentedSlider;

//MARK: - Plist文件的Key [兼容iOS Setting.bundle]
// 公用
FOUNDATION_EXPORT NSString *const VP_Type;
FOUNDATION_EXPORT NSString *const VP_Title;
FOUNDATION_EXPORT NSString *const VP_DefaultValue;
FOUNDATION_EXPORT NSString *const VP_Key;
// MultiValues
FOUNDATION_EXPORT NSString *const VP_Titles;
FOUNDATION_EXPORT NSString *const VP_Values;
// TextField
FOUNDATION_EXPORT NSString *const VP_IsSecure;
FOUNDATION_EXPORT NSString *const VP_Keyboard;
FOUNDATION_EXPORT NSString *const VP_Autocapital;
FOUNDATION_EXPORT NSString *const VP_Autocorrect;
// Slider && SegmentedSlider
FOUNDATION_EXPORT NSString *const VP_MaxVal;
FOUNDATION_EXPORT NSString *const VP_MinVal;
FOUNDATION_EXPORT NSString *const VP_MaxImage;
FOUNDATION_EXPORT NSString *const VP_MinImage;

//MARK: [自定义]
FOUNDATION_EXPORT NSString *const VP_Segments;
FOUNDATION_EXPORT NSString *const VP_CustomCell;
FOUNDATION_EXPORT NSString *const VP_ToggleKey;
