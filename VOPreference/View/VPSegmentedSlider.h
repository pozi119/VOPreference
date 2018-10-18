//
//  VPSegmentedSlider.h
//  VOPreference
//
//  Created by Valo on 2018/10/12.
//  Copyright © 2018 Valo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VPSegmentedSlider : UIControl

@property (nonatomic, copy) void(^interactionBegan)(void);
@property (nonatomic, copy) void(^interactionEnded)(void);
@property (nonatomic, copy) void(^reset)(void);

@property (nonatomic, assign) UIInterfaceOrientation interfaceOrientation;

@property (nonatomic, assign) CGFloat minimumValue;
@property (nonatomic, assign) CGFloat maximumValue;

@property (nonatomic, assign) CGFloat startValue;
@property (nonatomic, assign) CGFloat value;

@property (nonatomic, assign) CGFloat markValue;

@property (nonatomic, readonly) bool knobStartedDragging;

@property (nonatomic, assign) CGFloat knobPadding;
@property (nonatomic, assign) CGFloat lineSize;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, assign) CGFloat trackCornerRadius;
@property (nonatomic, assign) bool bordered;

@property (nonatomic, strong) UIImage *knobImage;
@property (nonatomic, readonly) UIImageView *knobView;

@property (nonatomic, assign) NSInteger positionsCount;
@property (nonatomic, assign) CGFloat dotSize;

@property (nonatomic, assign) bool enablePanHandling;

- (void)setValue:(CGFloat)value animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
