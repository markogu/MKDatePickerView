//
//  DatePickerView.m
//  时间选择器
//
//  Created by 顾嘉峰 on 2016/11/18.
//  Copyright © 2016年 gujiafeng. All rights reserved.
//

#define SCREEN_WIDTH                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define PICKERVIEW_HEIGHT           250

#import "DatePickerView.h"

@interface DatePickerView ()
@property (retain, nonatomic) UIView *baseView;
@property (strong, nonatomic) UIDatePicker *datePicker;
@end

@implementation DatePickerView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
        _baseView.backgroundColor = [UIColor colorWithRed:0.94 green:0.95 blue:0.95 alpha:1.0];
        [self addSubview:_baseView];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        line1.backgroundColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.77 alpha:1.0];
        [_baseView addSubview:line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        line2.backgroundColor = [UIColor colorWithRed:0.76 green:0.76 blue:0.77 alpha:1.0];
        [_baseView addSubview:line2];
        
        UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 0, 40, 40)];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        [btnOK setTitleColor:[UIColor colorWithRed:0.09 green:0.49 blue:0.98 alpha:1.0] forState:UIControlStateNormal];
        [btnOK addTarget:self action:@selector(pickerViewBtnOK:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnOK];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor colorWithRed:0.09 green:0.49 blue:0.98 alpha:1.0] forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_baseView addSubview:btnCancel];
        
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, PICKERVIEW_HEIGHT-41)];
        
        _datePicker.backgroundColor = [UIColor colorWithRed:0.79 green:0.80 blue:0.83 alpha:1.0];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        _datePicker.date = [NSDate date];
        [_baseView addSubview:_datePicker];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePickerView)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

- (void)setMode:(PickerModeType)mode {
    if (mode == pickerDateMode) {
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }else {
        _datePicker.datePickerMode = UIDatePickerModeTime;
    }
    _mode = mode;
}

- (void)popDatePickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
    
}

//取消pickerView
- (void)dismissDatePickerView
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
                     }];
}

//确定
- (void)pickerViewBtnOK:(id)sender
{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //设置时区
    
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ZH_cn"];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear |
    
    NSCalendarUnitMonth |
    
    NSCalendarUnitDay |
    
    NSCalendarUnitWeekday |
    
    NSCalendarUnitHour |
    
    NSCalendarUnitMinute |
    
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate: self.datePicker.date];
    
    NSInteger week = [comps weekday];
    
    NSInteger year =[comps year];
    
    NSInteger month = [comps month];
    
    NSInteger day = [comps day];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"HH:mm";
    
    if (self.mode == pickerDateMode) {
        self.date_picker = [NSString stringWithFormat:@"%zi年%zi月%zi日 %@",year,month,day,[arrWeek objectAtIndex:(week - 1)]];
    }else{
        self.date_picker =[formatter stringFromDate:self.datePicker.date];
    }

    if (self.selectBlock) {
        self.selectBlock(self.date_picker);
    }
    
    [self dismissDatePickerView];
}

//取消
- (void)pickerViewBtnCancel:(id)sender
{
    [self dismissDatePickerView];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
