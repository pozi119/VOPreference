//
//  VPDatePickerCell.m
//  EnigmaPreference
//
//  Created by Valo on 2018/10/20.
//

#define VPDatePickerHeight  216.0

#import "VPDatePickerCell.h"

@interface VPDatePickerCell ()
@property (nonatomic, strong) UILabel         *titleLbl;
@property (nonatomic, strong) UILabel         *valueLbl;
@property (nonatomic, strong) UIDatePicker    *picker;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation VPDatePickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
        _formatter = [[NSDateFormatter alloc] init];
    }
    return self;
}
+ (CGFloat)height:(BOOL)spread{
    return 44.0f + (spread ? VPDatePickerHeight : 0.0);
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    UIDatePickerMode mode      = entry.datePickerMode;
    if(entry.datePickerMode < UIDatePickerModeTime || entry.datePickerMode > UIDatePickerModeDateAndTime){
        mode = UIDatePickerModeTime;
    }
    switch (mode) {
        case UIDatePickerModeTime: self.formatter.dateFormat = @"HH:mm"; break;
        case UIDatePickerModeDate: self.formatter.dateFormat = @"YYYY-MM-dd"; break;
        case UIDatePickerModeDateAndTime: self.formatter.dateFormat = @"YYYY-MM-dd HH:mm"; break;
        default: break;
    }
    self.titleLbl.text         = entry.title;
    self.picker.minimumDate    = entry.minValue;
    self.picker.maximumDate    = entry.maxValue;
    self.picker.datePickerMode = mode;
    self.picker.date           = entry.settingValue;
    self.valueLbl.text         = [self.formatter stringFromDate:self.picker.date];
}

- (void)setupSubviews{
    CGFloat width       = [UIScreen mainScreen].bounds.size.width;
    CGRect frame        = CGRectMake(0, 0, width, 44);
    UIControl *control  = [[UIControl alloc] initWithFrame:frame];
    [control addTarget:self action:@selector(toggleCell:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    
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
    frame.size.height   = VPDatePickerHeight;
    frame.size.width    = width - 40;
    _picker = [[UIDatePicker alloc] initWithFrame:frame];
    [_picker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_picker];
}

- (void)valueChanged:(UIDatePicker *)sender{
    [self.entry setSettingValue:sender.date];
    self.valueLbl.text = [self.formatter stringFromDate:sender.date];
}

- (void)toggleCell:(id)sender{
    UITableView *tableView = (UITableView *)self.superview;
    if(![tableView isKindOfClass:UITableView.class]) return;
    
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    if(!indexPath) return;
    
    self.entry.spread = !self.entry.spread;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
