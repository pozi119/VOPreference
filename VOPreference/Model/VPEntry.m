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
    entry.typeString = dictionary[VP_Type];
    entry.type       = [self entryTypeOf:entry.typeString];
    entry.title      = dictionary[VP_Title];
    entry.key        = dictionary[VP_Key];
    entry.defaultVal = dictionary[VP_DefaultValue];
    entry.cellAction = dictionary[VP_CellAction];
    entry.toggleKey  = dictionary[VP_ToggleKey];
    switch (entry.type) {
        case VPEntryTypeCustom:{
            entry.customCell = dictionary[VP_CustomCell];
        } break;
            
        case VPEntryTypeMultiVal:{
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
        case VPEntryTypeSegmentedSlider:{
            entry.maxValue    = [dictionary[VP_MaxVal] floatValue];
            entry.minValue    = [dictionary[VP_MinVal] floatValue];
            entry.maxValImage = dictionary[VP_MaxImage];
            entry.minValImage = dictionary[VP_MinImage];
            if(entry.type == VPEntryTypeSegmentedSlider){
                entry.segmentsCount = [dictionary[VP_Segments] integerValue];
            }
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
    [[NSNotificationCenter defaultCenter] postNotificationName:VOPreferenceDidChangeNotification object:value userInfo:@{@"entry":self}];
}

+ (VPEntryType)entryTypeOf:(NSString *)typeString{
    NSDictionary *map = @{VPType_Group           : @(VPEntryTypeGroup),
                          
                          VPType_Title           : @(VPEntryTypeTitle),
                          VPType_MulitVal        : @(VPEntryTypeMultiVal),
                          VPType_TextField       : @(VPEntryTypeTextField),
                          VPType_Switch          : @(VPEntryTypeSwitch),
                          VPType_Slider          : @(VPEntryTypeSlider),
                          VPType_Button          : @(VPEntryTypeButton),
                          
                          VPType_SegmentedSlider : @(VPEntryTypeSegmentedSlider),
                          VPType_GroupFooter     : @(VPEntryTypeGroupFooter)};
    
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

@end
