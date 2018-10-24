//
//  VPStepperCell.m
//  EnigmaPreference
//
//  Created by Valo on 2018/10/20.
//

#import "VPStepperCell.h"
#import "VPStepper.h"

@interface VPStepperCell ()
@property (nonatomic, strong) VPStepper *stepper;
@end

@implementation VPStepperCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _stepper = [VPStepper new];
    [_stepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = _stepper;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    id val = [entry settingValue];
    self.textLabel.text = entry.title;
    _stepper.minimumValue = [entry.minValue doubleValue];
    _stepper.maximumValue = [entry.maxValue doubleValue];
    _stepper.stepValue    = entry.stepValue;
    _stepper.value = [val doubleValue];
}

- (void)stepperValueChanged:(UIStepper *)sender{
    NSNumber *val = @(sender.value);
    [self.entry setSettingValue:val];
}

@end
