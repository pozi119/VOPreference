//
//  VPSetting.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//

#import "VPSetting.h"
#import "VPEntryGroup.h"

@interface VPSetting ()
@property (nonatomic, strong) NSArray                 *entries;
@property (nonatomic, strong) NSMutableDictionary     *keyValues;
@property (nonatomic, strong) NSString                *entriesFilePath;
@property (nonatomic, strong) NSArray<VPEntryGroup *> *groupedEntires;

@end

@implementation VPSetting{
    NSMutableDictionary *_keyValues;
    NSString *_entriesFilePath;
    NSArray<VPEntryGroup *> *_groupedEntires;
}

- (instancetype)initWithEntiresFile:(NSString *)entriesFilePath{
    self = [super init];
    if (self) {
        BOOL isdir = NO;
        BOOL exist = [NSFileManager.defaultManager fileExistsAtPath:entriesFilePath isDirectory:&isdir];
        if(!exist || isdir) return nil;
        _entriesFilePath = entriesFilePath;
        [self setValueForEntryKey:^id (NSString *entryKey) {
            return [[NSUserDefaults standardUserDefaults] objectForKey:entryKey];
        }];
        [self setSetValueForEntryKey:^(NSString * entryKey, id val) {
            [[NSUserDefaults standardUserDefaults] setObject:val forKey:entryKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    }
    return self;
}

- (NSString *)entriesFilePath{
    return _entriesFilePath;
}

- (NSArray *)entries{
    if (!_entries) {
        _entries = [self entriesWithContentsOfFile:self.entriesFilePath];
    }
    return _entries;
}

- (NSArray<VPEntryGroup *> *)groupedEntires{
    if (!_groupedEntires) {
        _groupedEntires = [self groupEntries:self.entries];
    }
    return _groupedEntires;
}

- (NSMutableDictionary *)keyValues{
    if (!_keyValues) {
        _keyValues = [self settingsOfEntries:self.entries];
    }
    return _keyValues;
}

- (NSArray *)entriesWithContentsOfFile:(NSString *)path{
    NSDictionary *dictinary    = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *array             = dictinary[@"PreferenceSpecifiers"];
    NSMutableArray *entries    = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in array) {
        VPEntry *entry = [VPEntry entryWithDictionary:dic];
        entry.setting       = self;
        if(entry) [entries addObject:entry];
    }
    return entries;
}

- (NSArray *)groupEntries:(NSArray<VPEntry *> *)entries{
    NSMutableArray *grouped     = [NSMutableArray arrayWithCapacity:0];
    VPEntry *header             = nil;
    VPEntry *footer             = nil;
    NSMutableArray *subEntires  = [NSMutableArray arrayWithCapacity:0];
    
    for (VPEntry *entry in entries) {
        BOOL addGroup = NO;
        switch (entry.type) {
            case VPEntryTypeGroup: {
                if(header || subEntires.count > 0){
                    addGroup = YES;
                }
                header = entry;
            } break;
             
            case VPEntryTypeGroupFooter:{
                footer = entry;
                addGroup = YES;
            } break;
                
            default:{
                [subEntires addObject:entry];
            } break;
        }
        if(addGroup){
            [grouped addObject:[VPEntryGroup groupWithHeader:header footer:footer entries:subEntires]];
            header = nil;
            footer = nil;
            subEntires = [NSMutableArray arrayWithCapacity:0];
        }
    }
    if(header || footer || subEntires.count > 0){
        [grouped addObject:[VPEntryGroup groupWithHeader:header footer:footer entries:subEntires]];
    }
    
    return grouped;
}

- (NSMutableDictionary *)settingsOfEntries:(NSArray<VPEntry *> *)entries{
    NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithCapacity:0];
    for (VPEntry *entry  in entries) {
        if(entry.key.length == 0) continue;
        id value = self.valueForEntryKey(entry.key);
        if (!value) {
            value = entry.defaultVal;
            self.setValueForEntryKey(entry.key, value);
        }
        settings[entry.key] = value;
    }
    return settings;
}

@end
