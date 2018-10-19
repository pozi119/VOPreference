//
//  VOPreferenceDefs.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//

#import "VOPreferenceDefs.h"

//MARK: - 通知
NSString *const VOPreferenceDidChangeNotification  = @"VOPreferenceDidChangeNotification";

//MARK: - 配置项类型 [兼容iOS Setting.bundle]
NSString *const VPType_Group     = @"PSGroupSpecifier";
NSString *const VPType_Title     = @"PSTitleValueSpecifier";
NSString *const VPType_MulitVal  = @"PSMultiValueSpecifier";
NSString *const VPType_TextField = @"PSTextFieldSpecifier";
NSString *const VPType_Switch    = @"PSToggleSwitchSpecifier";
NSString *const VPType_Slider    = @"PSSliderSpecifier";
//MARK: [自定义]
NSString *const VPType_Button    = @"PSButtonSpecifier";
NSString *const VPType_Custom    = @"PSCustomSpecifier";
NSString *const VPType_GroupFooter     = @"PSGroupFooterSpecifier";
NSString *const VPType_SegmentedSlider = @"PSSegmentedSliderSpecifier";

//MARK: - Plist文件的Key [兼容iOS Setting.bundle]
// 公用
NSString *const VP_Type          = @"Type";
NSString *const VP_Title         = @"Title";
NSString *const VP_DefaultValue  = @"DefaultValue";
NSString *const VP_Key           = @"Key";
// MultiValues
NSString *const VP_Titles        = @"Titles";
NSString *const VP_Values        = @"Values";
// TextField
NSString *const VP_IsSecure      = @"IsSecure";
NSString *const VP_Keyboard      = @"KeyboardType";
NSString *const VP_Autocapital   = @"AutocapitalizationType";
NSString *const VP_Autocorrect   = @"AutocorrectionType";
// Slider && SegmentedSlider
NSString *const VP_MaxVal        = @"MaximumValue";
NSString *const VP_MinVal        = @"MinimumValue";
NSString *const VP_MaxImage      = @"MaximumValueImage";
NSString *const VP_MinImage      = @"MinimumValueImage";

//MARK: [自定义]
NSString *const VP_Segments      = @"SegmentsCount";
NSString *const VP_CustomCell    = @"CustomCell";
NSString *const VP_ToggleKey     = @"ToggleKey";
