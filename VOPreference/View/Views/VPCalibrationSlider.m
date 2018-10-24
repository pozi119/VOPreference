//
//  VPCalibrationSlider.h
//  VOPreference
//
//  Created by Valo on 2018/10/18.
//  Copyright © 2018 Valo. All rights reserved.
//

#import "VPCalibrationSlider.h"

@interface VPCalibrationSlider ()
@property (nonatomic, strong) UIView  *calibrationsView;
@property (nonatomic, strong) NSArray *calibrationLayers;
@end

@implementation VPCalibrationSlider

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)setup{
    [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(bounceToCalibration:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setCalibrationCount:(NSUInteger)calibrationCount{
    _calibrationCount = calibrationCount;
    [self setNeedsLayout];
}

- (void)setCalibrationType:(VPCalibrationType)calibrationType{
    _calibrationType = calibrationType;
    [self setNeedsLayout];
}

- (void)setCalibrationSize:(CGSize)calibrationSize{
    _calibrationSize = calibrationSize;
    [self setNeedsLayout];
}

- (void)setupCalibrationsViewWithSliderRect:(CGRect)rect{
    BOOL isDot        = _calibrationType == VPCalibrationDot;
    CGSize size       = _calibrationSize;
    
    // 默认值
    if(size.width == 0 || size.height == 0) {
        size = CGSizeMake(2, isDot? 2 : 4);
    }
    // 创建View
    CGFloat width     = rect.size.width - 4; // UISlider的进度条长度
    CGRect frame      = rect;
    frame.origin.x    = 2;
    frame.origin.y    = (rect.size.height - size.height) / 2;
    frame.size.width  = width;
    frame.size.height = size.height;
    UIView *view      = [[UIView alloc] initWithFrame:frame];
    
    // 计算并设置Calibration Layer
    CGFloat radius      = MIN(size.width, size.height) / 2.0f;
    CGFloat y           = size.height / 2;
    CGPoint anchorPoint = CGPointMake(0.5, isDot ? 0.5 : 1);
    UIColor *bgcolor    = self.backgroundColor ? : [UIColor whiteColor];
    NSMutableArray *calibrationLayers = [NSMutableArray arrayWithCapacity:_calibrationCount];
    
    for (NSUInteger i = 0; i < _calibrationCount + 1; i ++) {
        CGFloat x = ((width - size.width) / _calibrationCount) * i + radius;
        
        if(isDot){
            CALayer *bgLayer        = [CALayer new];
            bgLayer.backgroundColor = bgcolor.CGColor;
            bgLayer.anchorPoint     = anchorPoint;
            bgLayer.bounds          = CGRectMake(0, 0, size.width * 2, size.height * 2);
            bgLayer.cornerRadius    = radius;
            bgLayer.masksToBounds   = YES;
            bgLayer.position        = CGPointMake(x, y);
            [view.layer addSublayer:bgLayer];
        }
        
        CALayer *calibrationLayer         = [CALayer new];
        calibrationLayer.anchorPoint      = anchorPoint;
        calibrationLayer.bounds           = CGRectMake(0, 0, size.width, size.height);
        calibrationLayer.cornerRadius     = isDot ? radius / 2 : 0;
        calibrationLayer.masksToBounds    = YES;
        calibrationLayer.position         = CGPointMake(x, y);
        [view.layer addSublayer:calibrationLayer];
        [calibrationLayers addObject:calibrationLayer];
    }
    self.calibrationLayers = [calibrationLayers copy];
    [self setupCalibrationLayersColor];
    self.calibrationsView = view;
}

- (void)setupCalibrationLayersColor{
    CGColorRef tintColor = self.tintColor.CGColor;
    CGColorRef grayColor = [UIColor lightGrayColor].CGColor;
    CGFloat valuefraction = (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue);
    for (CALayer *layer in self.calibrationLayers) {
        CGFloat centerx = layer.frame.origin.x + layer.frame.size.width / 2;
        CGFloat fraction = centerx / self.bounds.size.width;
        layer.backgroundColor = fraction < valuefraction ? tintColor : grayColor;
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self.calibrationsView removeFromSuperview];
    if(_calibrationCount > 0){
        UIView *minView  = self.subviews[1];
        [self setupCalibrationsViewWithSliderRect:rect];
        [self insertSubview:self.calibrationsView aboveSubview:minView];
    }
}

- (void)valueChanged:(id)sender{
    [self setupCalibrationLayersColor];
}

- (void)bounceToCalibration:(id)sender{
    if(_allowNonCalibrationValue) return;
    CGFloat perVal   = (self.maximumValue - self.minimumValue) * 1.0 /  _calibrationCount;
    NSUInteger index =  (NSUInteger)roundf((self.value - self.minimumValue) / perVal);
    CGFloat newVal   = self.minimumValue + index * perVal;
    [self setValue:newVal animated:YES];
    [self setupCalibrationLayersColor];
}

@end
