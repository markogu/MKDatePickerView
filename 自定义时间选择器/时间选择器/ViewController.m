//
//  ViewController.m
//  时间选择器
//
//  Created by 顾嘉峰 on 2016/11/18.
//  Copyright © 2016年 gujiafeng. All rights reserved.
//

#import "ViewController.h"
#import "DatePickerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong) DatePickerView *dateview;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.dateview = [[DatePickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    self.dateview.mode = pickerDateMode;
    [self.view addSubview:self.dateview];
    __block ViewController *blockSelf = self;
    self.dateview.selectBlock = ^(NSString *str) {
        blockSelf.label.text = str;
    };
}

- (IBAction)clickBtn:(id)sender {
    
    [self.dateview popDatePickerView];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
