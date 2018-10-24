//
//  VPStepper.m
//  EnigmaPreference
//
//  Created by Valo on 2018/10/22.
//


#define VPStepperMinW  150
#define VPStepperMinH  30

#import "VPStepper.h"
#import "NSNumber+VOPreference.h"

@interface VPStepper () <UITextFieldDelegate>
@property(nonatomic, strong) UIButton    *decrButton;
@property(nonatomic, strong) UITextField *valueField;
@property(nonatomic, strong) UIButton    *incrButton;

@property(nonatomic, strong) UIView      *decrSpliter;
@property(nonatomic, strong) UIView      *incrSpliter;

@property(nonatomic, assign) BOOL        inRepeat;
@property(nonatomic, assign) BOOL        doRepeat;

@end

@implementation VPStepper

- (instancetype)initWithFrame:(CGRect)frame
{
    frame.size.width  = MAX(frame.size.width,  VPStepperMinW);
    frame.size.height = MAX(frame.size.height, VPStepperMinH);
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        CGRect frame = self.frame;
        frame.size.width  = MAX(frame.size.width,  VPStepperMinW);
        frame.size.height = MAX(frame.size.height, VPStepperMinH);
        self.frame = frame;
        [self setup];
        [self setupSubviews];
    }
    return self;
}

- (void)setup{
    _continuous   = YES;
    _autorepeat   = YES;
    _wraps        = YES;
    _maximumValue = 100;
    _stepValue    = 1;
    _borderWidth  = 1.0;
    _splitWidth   = 1.0;
}

- (void)setupSubviews{
    self.layer.cornerRadius = 5;
    
    _decrButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_decrButton setTitle:@"－" forState:UIControlStateNormal];
    [_decrButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_decrButton addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_decrButton];
    
    _valueField               = [UITextField new];
    _valueField.textColor     = [UIColor grayColor];
    _valueField.textAlignment = NSTextAlignmentCenter;
    _valueField.delegate      = self;
    _valueField.keyboardType  = UIKeyboardTypeNumberPad;
    [_valueField addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_valueField];
    
    _incrButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_incrButton setTitle:@"＋" forState:UIControlStateNormal];
    [_incrButton addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_incrButton addTarget:self action:@selector(onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_incrButton];

    _decrSpliter = [UIView new];
    [self addSubview:_decrSpliter];
    
    _incrSpliter = [UIView new];
    [self addSubview:_incrSpliter];

    [self setNeedsLayout];
}

- (void)setBorderWidth:(double)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = self.tintColor.CGColor;
}

- (void)setSplitWidth:(double)splitWidth{
    _splitWidth = splitWidth;
    [self setNeedsLayout];
}

- (void)setValue:(double)value{
    if(_wraps && (value < _minimumValue || value > _maximumValue)) return;
    _value = value;
    if(_wraps){
        _decrButton.enabled = value - _stepValue >= _minimumValue;
        _incrButton.enabled = value + _stepValue <= _maximumValue;
    }
    self.valueField.text = @(value).vp_stringValue;
    if(_continuous){
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat width  = rect.size.width / 3;
    CGFloat height = rect.size.height;
    
    _decrButton.frame  = CGRectMake(width * 0, 0, width, height);
    _valueField.frame  = CGRectMake(width * 1, 0, width, height);
    _incrButton.frame  = CGRectMake(width * 2, 0, width, height);
    
    _decrSpliter.frame = CGRectMake(width * 1 - _splitWidth / 2, 0, _splitWidth, height);
    _incrSpliter.frame = CGRectMake(width * 2 - _splitWidth / 2, 0, _splitWidth, height);
    _decrSpliter.backgroundColor = self.tintColor;
    _incrSpliter.backgroundColor = self.tintColor;
    
    self.value = _value;
    self.borderWidth = _borderWidth;
}

//MARK: - Actions

- (void)onTouchDown:(UIButton *)sender{
    [self.valueField endEditing:YES];
    if(_autorepeat){
        _doRepeat = YES;
        BOOL incr = [sender isEqual:self.incrButton];
        [self repeat:incr];
    }
}

- (void)onTouchUpInside:(UIButton *)sender{
    if(_autorepeat){
        _doRepeat = NO;
    }
    else{
        BOOL incr = [sender isEqual:self.incrButton];
        [self changeValue:incr];
    }
}

- (void)repeat:(BOOL)incr{
    if (!self.inRepeat) {
        self.inRepeat = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.inRepeat = NO;
            [self changeValue:incr];
            if (self.doRepeat) {
                [self repeat:incr];
            }
        });
    }
}

- (void)changeValue:(BOOL)incr{
    self.value += incr ? _stepValue : - _stepValue;
}

- (void)editingChanged:(UITextField *)sender{
    self.value = sender.text.doubleValue;
}

//MARK: - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSMutableString *willText = [[NSMutableString alloc] initWithString:textField.text];
    [willText appendString:string];
    NSRange r = [willText rangeOfString:@"^[0-9]+\\.{0,1}[0-9]*$" options:NSRegularExpressionSearch];
    if (r.location == NSNotFound) {
        [self sendActionsForControlEvents:UIControlEventVPStepprInvalidValue];
        return NO;
    }
    if (!_wraps) return YES;
    double val = willText.doubleValue;
    if (val < _minimumValue || val > _maximumValue) {
        [self sendActionsForControlEvents:UIControlEventVPStepprOutOfBounds];
        return NO;
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *val = textField.text;
    self.value = val.doubleValue;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

@end
