# VOPreference

[![CI Status](https://img.shields.io/travis/pozi119/VOPreference.svg?style=flat)](https://travis-ci.org/pozi119/VOPreference)
[![Version](https://img.shields.io/cocoapods/v/VOPreference.svg?style=flat)](https://cocoapods.org/pods/VOPreference)
[![License](https://img.shields.io/cocoapods/l/VOPreference.svg?style=flat)](https://cocoapods.org/pods/VOPreference)
[![Platform](https://img.shields.io/cocoapods/p/VOPreference.svg?style=flat)](https://cocoapods.org/pods/VOPreference)

## Usage

1. 使用XCode文件模板,添加setting.bundle
2. 拷贝setting.bundle中的plist文件到项目中
3. 使用代码创建并跳转设置页面,示例如下:

```objc
    NSString *path = [[NSBundle mainBundle] pathForResource:@"manual" ofType:@"plist"];
    VPSetting *setting = [[VPSetting alloc] initWithEntiresFile:path];
    VOPreferenceController *settingVC = [[VOPreferenceController alloc] init];
    settingVC.setting = setting;
    [self.navigationController pushViewController:settingVC animated:YES];
```
## Note

默认使用 NSUserDefaults 保存配置, 也可以设置为其他方式保存.

```objc
    [setting setValueForEntryKey:^id(NSString * entryKey) {
        // load val for entryKey
    }];
    [setting setSetValueForEntryKey:^(NSString *  entryKey, id val) {
        // save val for entryKey
    }];
```

## Requirements

## Installation

VOPreference is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VOPreference'
```

## Author

pozi119, pozi119@163.com

## License

VOPreference is available under the MIT license. See the LICENSE file for more info.
