//
//  VOViewController.m
//  VOPreference
//
//  Created by pozi119 on 10/13/2018.
//  Copyright (c) 2018 pozi119. All rights reserved.
//

#import "VOViewController.h"
#import "VOPreference.h"

@interface VOViewController ()

@end

@implementation VOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showSetting:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"manual" ofType:@"plist"];
    VPSetting *setting = [[VPSetting alloc] initWithEntiresFile:path];    
    VOPreferenceController *settingVC = [[VOPreferenceController alloc] init];
    settingVC.setting = setting;
    [self.navigationController pushViewController:settingVC animated:YES];
}

@end
