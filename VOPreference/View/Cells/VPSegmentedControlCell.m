//
//  VPSegmentedControlCell.m
//  EnigmaPreference
//
//  Created by Valo on 2018/10/20.
//

#import "VPSegmentedControlCell.h"

@interface VPSegmentedControlCell ()
@property (nonatomic, strong) UILabel            *titleLbl;
@property (nonatomic, strong) UILabel            *valueLbl;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@end

@implementation VPSegmentedControlCell

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

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    self.titleLbl.text = entry.title;
    
    [self.segmentedControl removeAllSegments];
    for (NSUInteger i = 0; i < entry.titles.count; i ++) {
        [self.segmentedControl insertSegmentWithTitle:entry.titles[i] atIndex:i animated:NO];
    }
    
    id val = entry.settingValue;
    NSInteger idx = [entry.values indexOfObject:val];
    if (idx < entry.titles.count) {
        self.valueLbl.text = entry.titles[idx];
        self.segmentedControl.selectedSegmentIndex = idx;
    }
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
    frame.size.height   = 34;
    frame.size.width    = width - 40;
    _segmentedControl = [[UISegmentedControl alloc] initWithFrame:frame];
    [_segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_segmentedControl];
}

- (void)valueChanged:(id)sender{
    NSUInteger idx = self.segmentedControl.selectedSegmentIndex;
    if(idx < self.entry.values.count){
        id val = self.entry.values[idx];
        [self.entry setSettingValue:val];
        self.valueLbl.text = self.entry.titles[idx];
    }
}

@end
