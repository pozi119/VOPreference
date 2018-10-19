//
//  VPSegmentedSliderCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/17.
//

#import "VPSegmentedSliderCell.h"
#import "VPCalibrationSlider.h"

@interface VPSegmentedSliderCell ()
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *valueLbl;
@property (nonatomic, strong) VPCalibrationSlider *slider;
@end

@implementation VPSegmentedSliderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    self.slider.minimumValue = entry.minValue;
    self.slider.maximumValue = entry.maxValue;
    self.slider.calibrationCount = entry.segmentsCount;
    self.slider.value = [entry.settingValue floatValue];
    self.titleLbl.text = entry.title;
    self.valueLbl.text = @((NSInteger)self.slider.value).stringValue;
}

- (void)setupSubviews{
    self.cellHeight     = 88.f;
    
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
    _valueLbl.textColor = [UIColor darkGrayColor];
    _valueLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:_valueLbl];

    frame.origin.x      = 20;
    frame.origin.y      = 44;
    frame.size.height   = 44;
    frame.size.width    = width - 40;
    _slider = [[VPCalibrationSlider alloc] initWithFrame: frame];
    _slider.calibrationType = VPCalibrationLine;
    [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_slider];
}

- (void)valueChanged:(id)sender{
    [self.entry setSettingValue:@(self.slider.value)];
}

@end
