//
//  VPCalibrationSlider.h
//  VOPreference
//
//  Created by Valo on 2018/10/18.
//  Copyright © 2018 Valo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VPCalibrationType) {
    VPCalibrationDot,
    VPCalibrationLine,
};

NS_ASSUME_NONNULL_BEGIN

@interface VPCalibrationSlider : UISlider
@property (nonatomic, assign) VPCalibrationType calibrationType;    // 刻度类型
@property (nonatomic, assign) NSUInteger calibrationCount;          // 刻度的数量
@property (nonatomic, assign) CGSize     calibrationSize;           // 刻度大小
@property (nonatomic, assign) BOOL       allowNonCalibrationValue;  // 允许非刻度的值
@end

NS_ASSUME_NONNULL_END
