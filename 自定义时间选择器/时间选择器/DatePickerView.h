//
//  DatePickerView.h
//  时间选择器
//
//  Created by 顾嘉峰 on 2016/11/18.
//  Copyright © 2016年 gujiafeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PickerModeType){
    pickerDateMode = 0,
    pickerTimeMode = 1
};

typedef void (^MyBasicBlock)(id result);

@interface DatePickerView : UIView
@property(nonatomic,retain) NSString *date_picker;
@property (nonatomic, copy) MyBasicBlock selectBlock;
@property (nonatomic,assign) PickerModeType mode;

- (void)popDatePickerView;

@end
