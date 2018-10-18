//
//  VPEntryGroup.m
//  VOPreference
//
//  Created by Valo on 2018/10/17.
//

#import "VPEntryGroup.h"

@implementation VPEntryGroup

+ (instancetype)groupWithHeader:(VPEntry *)header
                         footer:(VPEntry *)footer
                        entries:(NSArray<VPEntry *> *)entries{
    VPEntryGroup *group = [VPEntryGroup new];
    group.header    = header;
    group.footer    = footer;
    group.entries   = entries;
    return group;
}

@end
