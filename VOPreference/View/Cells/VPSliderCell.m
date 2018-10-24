//
//  VPSliderCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPSliderCell.h"
#import "NSNumber+VOPreference.h"

@interface VPSliderCell ()
@property (nonatomic, strong) UILabel   *titleLbl;
@property (nonatomic, strong) UILabel   *valueLbl;
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

+ (CGFloat)height:(BOOL)spread{
    return 88.0f;
}

- (void)setupSubviews{
    CGRect frame        = self.bounds;
    CGFloat width       = [UIScreen mainScreen].bounds.size.width;
    frame.origin.x      = 20;
    frame.origin.y      = 12;
    frame.size.height   = 20.5;
    frame.size.width    = width - 20 - 100 - 10 - 20;
    _titleLbl           = [[UILabel alloc] initWithFrame:frame];
    _titleLbl.font      = [UIFont systemFontOfSize:17];
    _titleLbl.textColor = [UIColor darkTextColor];
    [self addSubview:_titleLbl];
    
    frame.origin.x      = width - 20 - 100;
    frame.size.width    = 100;
    _valueLbl           = [[UILabel alloc] initWithFrame:frame];
    _valueLbl.font      = [UIFont systemFontOfSize:17];
    _valueLbl.textColor = [UIColor grayColor];
    _valueLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:_valueLbl];
    
    frame.origin.x      = 20;
    frame.origin.y      = 44;
    frame.size.height   = 44;
    frame.size.width    = width - 40;
    _slider = [[UISlider alloc] initWithFrame: frame];
    [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_slider];
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    
    _slider.minimumValue = [entry.minValue floatValue];
    _slider.maximumValue = [entry.maxValue floatValue];
    if(entry.minValImage.length > 0)
        _slider.minimumValueImage = [UIImage imageNamed:entry.minValImage];
    if(entry.maxValImage.length > 0)
        _slider.maximumValueImage = [UIImage imageNamed:entry.maxValImage];
    _slider.value = [[entry settingValue] floatValue];
    
    _titleLbl.text = entry.title;
    _valueLbl.text = @(_slider.value).vp_stringValue;
}

- (void)valueChanged:(UISlider *)sender{
    [self.entry setSettingValue:@(sender.value)];
    self.valueLbl.text = @(sender.value).vp_stringValue;
}

@end
