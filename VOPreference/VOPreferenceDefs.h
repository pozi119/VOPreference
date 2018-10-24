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
FOUNDATION_EXPORT NSString *const VP_CellClass;
FOUNDATION_EXPORT NSString *const VP_ToggleKey;
FOUNDATION_EXPORT NSString *const VP_StepVal;
FOUNDATION_EXPORT NSString *const VP_DatePickerMode;
FOUNDATION_EXPORT NSString *const VP_ForegroundColor;
FOUNDATION_EXPORT NSString *const VP_BackgroundColor;
