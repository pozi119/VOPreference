//
//  VPSegmentedSliderCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/17.
//

#import "VPSegmentedSliderCell.h"
#import "VPSegmentedSlider.h"

@interface VPSegmentedSliderCell ()
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *valueLbl;
@property (nonatomic, strong) VPSegmentedSlider *slider;
@end

@implementation VPSegmentedSliderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        [self setupActions];
    }
    return self;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    self.slider.minimumValue = entry.minValue;
    self.slider.maximumValue = entry.maxValue;
    self.slider.positionsCount = entry.segmentsCount;
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
    _slider = [[VPSegmentedSlider alloc] initWithFrame: frame];
    _slider.backgroundColor   = [UIColor whiteColor];
    //_slider.knobImage = knobViewImage;
    _slider.trackCornerRadius = 1.0f;
    _slider.trackColor        = [UIColor colorWithRed:0.00 green:0.50 blue:0.90 alpha:1.00];
    _slider.backColor         = [UIColor colorWithRed:0.72 green:0.72 blue:0.72 alpha:1.00];
    _slider.lineSize          = 2.0f;
    _slider.dotSize           = 5.0f;
    _slider.minimumValue      = 0.0f;
    _slider.maximumValue      = 6.0f;
    _slider.startValue        = 0.0f;
    _slider.value             = 3.0f;
    _slider.positionsCount    = 7;
    [self addSubview:_slider];
}

- (void)setupActions{
    __weak typeof(self) weakSelf = self;
    [self.slider setInteractionEnded:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.entry setSettingValue:@(strongSelf.slider.value)];
    }];
}

@end
