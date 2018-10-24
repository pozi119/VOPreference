//
//  VPStepper.h
//  EnigmaPreference
//
//  Created by Valo on 2018/10/22.
//

#import <UIKit/UIKit.h>

#define UIControlEventVPStepprOutOfBounds   (1 << 20)
#define UIControlEventVPStepprInvalidValue  (1 << 21)

NS_ASSUME_NONNULL_BEGIN

@interface VPStepper : UIControl
@property(nonatomic,getter=isContinuous) BOOL continuous; // if YES, value change events are sent any time the value changes during interaction. default = YES
@property(nonatomic) BOOL autorepeat;                     // if YES, press & hold repeatedly alters value. default = YES
@property(nonatomic) BOOL wraps;                          // if YES, value wraps from min <-> max. default = NO

@property(nonatomic) double value;                        // default is 0. sends UIControlEventValueChanged. clamped to min/max
@property(nonatomic) double minimumValue;                 // default 0. must be less than maximumValue
@property(nonatomic) double maximumValue;                 // default 100. must be greater than minimumValue
@property(nonatomic) double stepValue;                    // default 1. must be greater than 0

@property(nonatomic) double borderWidth;                  // default 1.0

@property(nonatomic) double splitWidth;                   // default 1.0

@end

NS_ASSUME_NONNULL_END
