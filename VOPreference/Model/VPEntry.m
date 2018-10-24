//
//  VPEntry.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPEntry.h"
#import "VPSetting.h"

@implementation VPEntry

+ (instancetype)entryWithDictionary:(NSDictionary *)dictionary{
    if (!dictionary || !dictionary[VP_Type]) return nil;
    VPEntry *entry   = [VPEntry new];
    entry.type       = [self entryTypeOf:dictionary[VP_Type]];
    entry.title      = dictionary[VP_Title];
    entry.key        = dictionary[VP_Key];
    entry.defaultVal = dictionary[VP_DefaultValue];
    entry.toggleKey  = dictionary[VP_ToggleKey];
    entry.foregroundColor  = [self colorWithHexStr: dictionary[VP_ForegroundColor]];
    entry.backgroundColor  = [self colorWithHexStr: dictionary[VP_BackgroundColor]];
    entry.cellClass  = [self cellClassOf:entry.type];
    if(entry.cellClass.length == 0){
        entry.cellClass = dictionary[VP_CellClass];
    }
    switch (entry.type) {
        case VPEntryTypeCustom:{
            entry.cellClass = dictionary[VP_CellClass];
        } break;
            
        case VPEntryTypeMultiVal:
        case VPEntryTypeSegmentedControl:{
            entry.titles = dictionary[VP_Titles];
            entry.values = dictionary[VP_Values];
        } break;
        
        case VPEntryTypeTextField:{
            entry.secureTextEntry        = [dictionary[VP_IsSecure] boolValue];
            entry.autocapitalizationType = [self autocapitalizationTypeOf:dictionary[VP_Autocapital]];
            entry.autocorrectionType     = [self autocorrectionTypeOf:dictionary[VP_Autocorrect]];
            entry.keyboardType           = [self keyboardTypeOf:dictionary[VP_Keyboard]];
        } break;
            
        case VPEntryTypeSlider:
        case VPEntryTypeSegmentedSlider:
        case VPEntryTypeSteper:
        case VPEntryTypeDatePicker:{
            entry.maxValue       = dictionary[VP_MaxVal];
            entry.minValue       = dictionary[VP_MinVal];
            entry.maxValImage    = dictionary[VP_MaxImage];
            entry.minValImage    = dictionary[VP_MinImage];
            entry.segmentsCount  = [dictionary[VP_Segments] integerValue]; // segmentedSlider
            entry.stepValue      = [dictionary[VP_StepVal] floatValue];    // stepper
            entry.datePickerMode = [dictionary[VP_DatePickerMode] integerValue];  // datePicker
        }
        
        default:
            break;
    }
    
    return entry;
}

- (id)settingValue{
    if(self.key.length == 0) return nil;
    return self.setting.keyValues[self.key];
}

- (void)setSettingValue:(id)value{
    self.setting.keyValues[self.key] = value;
    self.setting.setValueForEntryKey(self.key, value);
    [[NSNotificationCenter defaultCenter] postNotificationName:VOPreferenceDidChangeNotification object:self userInfo:nil];
}

+ (NSString *)cellClassOf:(VPEntryType)type{
    NSDictionary *map = @{@(VPEntryTypeTitle)           : @"VPTitleCell",
                          @(VPEntryTypeMultiVal)        : @"VPMultiValCell",
                          @(VPEntryTypeTextField)       : @"VPTextFieldCell",
                          @(VPEntryTypeSwitch)          : @"VPSwitchCell",
                          @(VPEntryTypeSlider)          : @"VPSliderCell",
                          
                          @(VPEntryTypeButton)          : @"VPButtonCell",
                          @(VPEntryTypeSteper)          : @"VPStepperCell",
                          @(VPEntryTypeDatePicker)      : @"VPDatePickerCell",
                          @(VPEntryTypeSegmentedControl): @"VPSegmentedControlCell",
                          @(VPEntryTypeSegmentedSlider) : @"VPSegmentedSliderCell"};
    return map[@(type)];
}

+ (VPEntryType)entryTypeOf:(NSString *)typeString{
    NSDictionary *map = @{
                          // 兼容Setting.bundle
                          @"PSGroupSpecifier"           : @(VPEntryTypeGroup),
                          @"PSTitleValueSpecifier"      : @(VPEntryTypeTitle),
                          @"PSMultiValueSpecifier"      : @(VPEntryTypeMultiVal),
                          @"PSTextFieldSpecifier"       : @(VPEntryTypeTextField),
                          @"PSToggleSwitchSpecifier"    : @(VPEntryTypeSwitch),
                          @"PSSliderSpecifier"          : @(VPEntryTypeSlider),
                          // 自定义
                          @"PSCustomSpecifier"          : @(VPEntryTypeCustom),
                          @"PSButtonSpecifier"          : @(VPEntryTypeButton),
                          @"PSStepperSpecifier"         : @(VPEntryTypeSteper),
                          @"PSDatePickerSpecifier"      : @(VPEntryTypeDatePicker),
                          @"PSSegmentedControlSpecifier": @(VPEntryTypeSegmentedControl),
                          @"PSGroupFooterSpecifier"     : @(VPEntryTypeGroupFooter),
                          @"PSSegmentedSliderSpecifier" : @(VPEntryTypeSegmentedSlider)};

    return [self typeOf:typeString map:map defaultVal:VPEntryTypeCustom];
}

+ (UIKeyboardType)keyboardTypeOf:(NSString *)typeString{
    NSDictionary *map = @{@"Alphabet"              : @(UIKeyboardTypeAlphabet),
                          @"URL"                   : @(UIKeyboardTypeURL),
                          @"NumberPad"             : @(UIKeyboardTypeNumberPad),
                          @"NumbersAndPunctuation" : @(UIKeyboardTypeNumbersAndPunctuation),
                          @"EmailAddress"          : @(UIKeyboardTypeEmailAddress)};
    return [self typeOf:typeString map:map defaultVal:UIKeyboardTypeDefault];
}

+ (UITextAutocapitalizationType)autocapitalizationTypeOf:(NSString *)typeString{
    NSDictionary *map = @{@"None"          : @(UITextAutocapitalizationTypeNone),
                          @"Words"         : @(UITextAutocapitalizationTypeWords),
                          @"Sentences"     : @(UITextAutocapitalizationTypeSentences),
                          @"AllCharacters" : @(UITextAutocapitalizationTypeAllCharacters)};
    return [self typeOf:typeString map:map defaultVal:UIKeyboardTypeDefault];
}

+ (UITextAutocorrectionType)autocorrectionTypeOf:(NSString *)typeString{
    NSDictionary *map = @{@"No"      : @(UITextAutocorrectionTypeNo),
                          @"YES"     : @(UITextAutocorrectionTypeYes),
                          @"Default" : @(UITextAutocorrectionTypeDefault)};
    return [self typeOf:typeString map:map defaultVal:UIKeyboardTypeDefault];
}

+ (NSInteger)typeOf:(NSString *)typeString
                map:(NSDictionary *)map
         defaultVal:(NSInteger)defaultVal{
    NSInteger type = defaultVal;
    if(typeString.length > 0){
        NSNumber *num = map[typeString];
        if(num) type = num.unsignedIntegerValue;
    }
    return type;
}

+ (UIColor *)colorWithHexStr:(NSString *)hex {
    if (hex.length > 0) {
        int lcolorint =  (int)strtoul([hex UTF8String], 0, 16);
        return [UIColor colorWithRed:((float)((lcolorint & 0xFF0000) >> 16))/255.0
                               green:((float)((lcolorint & 0xFF00) >> 8))/255.0
                                blue:((float)(lcolorint & 0xFF))/255.0
                               alpha:1.0];
    }
    return nil;
}

@end
