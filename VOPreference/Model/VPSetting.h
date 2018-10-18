//
//  VPSetting.h
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//

#import <Foundation/Foundation.h>
#import "VOPreferenceDefs.h"
#import "VPEntryGroup.h"

NS_ASSUME_NONNULL_BEGIN

@interface VPSetting : NSObject
@property (nonatomic, strong, readonly) NSMutableDictionary     *keyValues;
@property (nonatomic, strong, readonly) NSString                *entriesFilePath;
@property (nonatomic, strong, readonly) NSArray<VPEntryGroup *> *groupedEntires;

@property (nonatomic, copy  ) void (^setValueForEntryKey)(NSString *entryKey, id val);
@property (nonatomic, copy  ) id   (^valueForEntryKey)(NSString *entryKey);

- (instancetype)initWithEntiresFile:(NSString *)entriesFilePath;

@end

NS_ASSUME_NONNULL_END
