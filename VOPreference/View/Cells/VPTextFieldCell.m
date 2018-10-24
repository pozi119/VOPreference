//
//  VPTextFieldCell.m
//  VOPreference
//
//  Created by Valo on 2018/10/13.
//  Copyright © 2018年 Valo. All rights reserved.
//

#import "VPTextFieldCell.h"

@interface VPTextFieldCell () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation VPTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    _textField = [[UITextField alloc] initWithFrame:self.bounds];
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.delegate = self;
    self.accessoryView = _textField;
}

- (void)setEntry:(VPEntry *)entry{
    [super setEntry:entry];
    self.textLabel.text               = entry.title;
    _textField.secureTextEntry        = entry.secureTextEntry;
    _textField.keyboardType           = entry.keyboardType;
    _textField.autocapitalizationType = entry.autocapitalizationType;
    _textField.autocorrectionType     = entry.autocorrectionType;
    _textField.placeholder            = entry.title;
    _textField.text                   = entry.settingValue;
    _textField.textColor              = entry.foregroundColor ? : [UIColor grayColor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *val = textField.text;
    [self.entry setSettingValue:val];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

@end
