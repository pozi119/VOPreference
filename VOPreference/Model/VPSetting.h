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


/**
 初始化Setting

 @param entriesFilePath entries文件路径
 @return Setting对象
 */
- (instancetype)initWithEntiresFile:(NSString *)entriesFilePath;

/**
 根据indexPath获取Entry,主要用于设置Entry的`selectionHandler`

 @param indexPath indexPath
 @return Entry对象
 */
- (VPEntry *)entryForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
