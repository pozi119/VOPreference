//
//  VPEntryGroup.h
//  VOPreference
//
//  Created by Valo on 2018/10/17.
//

#import <Foundation/Foundation.h>
#import "VPEntry.h"

NS_ASSUME_NONNULL_BEGIN

@interface VPEntryGroup : NSObject
@property (nonatomic, strong) VPEntry *header;
@property (nonatomic, strong) VPEntry *footer;
@property (nonatomic, strong) NSArray<VPEntry *> *entries;

+ (instancetype)groupWithHeader:(VPEntry *)header
                         footer:(VPEntry *)footer
                        entries:(NSArray<VPEntry *> *)entries;

@end

NS_ASSUME_NONNULL_END
