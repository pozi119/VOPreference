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
@property (nonatomic, strong) NSDictionary<NSIndexPath *,VPEntry *> *entryMap;
@end

@implementation VPSetting{
    NSMutableDictionary *_keyValues;
    NSString *_entriesFilePath;
    NSArray<VPEntryGroup *> *_groupedEntires;
}

//MARK: - Public
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

- (VPEntry *)entryForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.entryMap[indexPath];
}

- (NSString *)entriesFilePath{
    return _entriesFilePath;
}

//MARK: - Getter/Setter
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

- (NSDictionary<NSIndexPath *,VPEntry *> *)entryMap{
    if (!_entryMap) {
        NSMutableDictionary *map = [NSMutableDictionary dictionaryWithCapacity:0];
        for (VPEntryGroup *group in self.groupedEntires) {
            for (VPEntry *entry in group.entries) {
                map[entry.indexPath] = entry;
            }
        }
        _entryMap = [map copy];
    }
    return _entryMap;
}

- (NSMutableDictionary *)keyValues{
    if (!_keyValues) {
        _keyValues = [self settingsOfEntries:self.entries];
    }
    return _keyValues;
}

//MARK: - Private
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
    NSMutableArray *grouped   = [NSMutableArray arrayWithCapacity:0];
    __block NSInteger section = 0;
    __block NSInteger row     = 0;
    __block VPEntry *header   = nil;
    __block VPEntry *footer   = nil;
    __block NSMutableArray *subEntires  = [NSMutableArray arrayWithCapacity:0];

    void(^addOneGroup)(void) = ^(void) {
        [grouped addObject:[VPEntryGroup groupWithHeader:header footer:footer entries:subEntires]];
        header = nil;
        footer = nil;
        subEntires = [NSMutableArray arrayWithCapacity:0];
        section ++;
        row    = 0;
    };
    
    for (VPEntry *entry in entries) {
        switch (entry.type) {
            case VPEntryTypeGroup: {
                if(header || footer || subEntires.count > 0){
                    addOneGroup();
                }
                header = entry;
            } break;
                
            case VPEntryTypeGroupFooter:{
                footer = entry;
                addOneGroup();
            } break;
                
            default:{
                entry.indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                row ++;
                [subEntires addObject:entry];
            } break;
        }
    }
    if(header || footer || subEntires.count > 0){
        addOneGroup();
    }

    NSUInteger count = entries.count;
    for (NSInteger i = 0; i < count; i ++) {
        VPEntry *entryi = entries[i];
        NSMutableArray *relatives = [NSMutableArray arrayWithCapacity:0];
        if(entryi.type == VPEntryTypeMultiVal) {
            [relatives addObject:entryi.indexPath];
        }
        for (NSInteger j = 0; j < count; j ++) {
            if(i == j) continue;
            VPEntry *entryj = entries[j];
            if([entryi.key isEqualToString:entryj.key] || [entryi.key isEqualToString:entryj.toggleKey]){
                [relatives addObject:entryj.indexPath];
            }
        }
        entryi.relativeIndexPaths = [relatives copy];
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
