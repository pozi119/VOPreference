//
//  VPSliderCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPSliderCell.h"
@interface VPSliderCell ()
@property (nonatomic, strong) UISlider  *slider;
@end

@implementation VPSliderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    CGRect frame = self.bounds;
    frame.origin.x = 20;
    frame.size.width = [UIScreen mainScreen].bounds.size.width - 40;
    _slider = [[UISlider alloc] initWithFrame:frame];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_slider];
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    NSString *val = [entry settingValue];
    _slider.minimumValue = entry.minValue;
    _slider.maximumValue = entry.maxValue;
    if(entry.minValImage.length > 0)
        _slider.minimumValueImage = [UIImage imageNamed:entry.minValImage];
    if(entry.maxValImage.length > 0)
        _slider.maximumValueImage = [UIImage imageNamed:entry.maxValImage];
    _slider.value = [val floatValue];
}

- (void)sliderValueChanged:(UISlider *)sender{
    NSString *val = @(sender.value).stringValue;
    [self.entry setSettingValue:val];
}

@end
