//
//  NSNumber+VOPreference.m
//  EnigmaPreference
//
//  Created by Valo on 2018/10/24.
//

#import "NSNumber+VOPreference.h"

@implementation NSNumber (VOPreference)

- (NSString *)vp_stringValue{
    static NSNumberFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSNumberFormatter alloc] init];
        formatter.roundingMode = NSNumberFormatterRoundFloor;
        formatter.maximumFractionDigits = 2;
        formatter.minimumIntegerDigits = 1;
    });
    return [formatter stringFromNumber:self];
}

@end
