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
    VPEntryTypeGroupFooter,
    VPEntryTypeSegmentedSlider,
};

@class VPSetting;

@interface VPEntry : NSObject
@property (nonatomic, weak  ) VPSetting     *setting;

// 公用
@property (nonatomic, assign) VPEntryType    type;
@property (nonatomic, copy  ) NSString       *typeString;
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
@property (nonatomic, assign) CGFloat       maxValue;
@property (nonatomic, assign) CGFloat       minValue;
@property (nonatomic, copy  ) NSString      *maxValImage;
@property (nonatomic, copy  ) NSString      *minValImage;
// 自定义
@property (nonatomic, assign) NSUInteger    segmentsCount;  ///< SegmentedSlider分段数量
@property (nonatomic, copy  ) NSString      *customCell;    ///< 自定义Cell的Class名,需继承`VOPreferenceCell`
@property (nonatomic, copy  ) NSString      *cellAction;    ///< cell点击事件(或其他事件)对应的`Selector`
@property (nonatomic, copy  ) NSString      *toggleKey;     ///< 对应EntryKey的值为true时才显示

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
