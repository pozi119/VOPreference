//
//  VPEntry.h
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VPEntryType) {
    VPEntryTypeCustom,
    
    VPEntryTypeGroup,
    VPEntryTypeTitle,
    VPEntryTypeMultiVal,
    VPEntryTypeTextField,
    VPEntryTypeSwitch,
    VPEntryTypeSlider,

    VPEntryTypeButton,
    VPEntryTypeSteper,
    VPEntryTypeDatePicker,
    VPEntryTypeSegmentedControl,
    VPEntryTypeGroupFooter,
    VPEntryTypeSegmentedSlider,
};

@class VPSetting;

@interface VPEntry : NSObject
@property (nonatomic, weak  ) VPSetting     *setting;

// 公用
@property (nonatomic, assign) VPEntryType    type;
@property (nonatomic, copy  ) NSString       *title;
@property (nonatomic, copy  ) NSString       *defaultVal;
@property (nonatomic, copy  ) NSString       *key;
// MultiValues
@property (nonatomic, strong) NSArray        *titles;
@property (nonatomic, strong) NSArray        *values;
// TextField
@property (nonatomic, assign) BOOL                          secureTextEntry;
@property (nonatomic, assign) UIKeyboardType                keyboardType;
@property (nonatomic, assign) UITextAutocapitalizationType  autocapitalizationType;
@property (nonatomic, assign) UITextAutocorrectionType      autocorrectionType;
// Slider && SegmentedSlider
@property (nonatomic, strong) id            maxValue;
@property (nonatomic, strong) id            minValue;
@property (nonatomic, copy  ) NSString      *maxValImage;
@property (nonatomic, copy  ) NSString      *minValImage;
// SegmentedSlider
@property (nonatomic, assign) NSUInteger    segmentsCount;    ///< SegmentedSlider分段数量
// Button
@property (nonatomic, strong) UIColor       *foregroundColor; ///< 前景色,默认为nil
@property (nonatomic, strong) UIColor       *backgroundColor; ///< 背景色,默认为nil

// Custom
@property (nonatomic, copy  ) NSString      *cellClass;       ///< Cell的Class名,需继承`VOPreferenceCell`
@property (nonatomic, copy  ) NSString      *toggleKey;       ///< 对应EntryKey的值为true时才显示
@property (nonatomic, assign) CGFloat       stepValue;        ///< stepper
@property (nonatomic, assign) NSUInteger    datePickerMode;   ///< datePicker

// Action && Cell
@property (nonatomic, copy  ) void  (^selectionHandler)(VPEntry *entry);
@property (nonatomic, strong) NSIndexPath   *indexPath;
@property (nonatomic, strong) NSArray       *relativeIndexPaths;
@property (nonatomic, assign) BOOL          spread;        

/**
 从字典生成entry对象

 @param dictionary 字典
 @return entry对象
 */
+ (instancetype)entryWithDictionary:(NSDictionary *)dictionary;

/**
 获取entry对应配置的值

 @return 配置对应的值
 */
- (id)settingValue;

/**
 设置entry对应配置的值

 @param value 配置对应的值
 */
- (void)setSettingValue:(id)value;

@end
