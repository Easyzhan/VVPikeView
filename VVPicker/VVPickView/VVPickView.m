//
//  VVPickView.m
//  VVPicker
//
//  Created by Vizard on 16/7/28.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#define SCREENSIZE [UIScreen mainScreen].bounds.size

#define SELF_HEIGHT 300 //self.view的高度，可自由调节

#import "VVPickView.h"

@implementation VVPickView
{
    
    NSArray *proTitleList;
    
    NSString *selectedStr;
    
    BOOL isDate;

}

@synthesize block;

- (instancetype)initWithFrame:(CGRect)frame{
  
    self = [super initWithFrame:frame];
    
    isDate = NO;
    
    return self;
}

/** 展示PickView在哪个Vc上 */
- (void)showPickView:(UIViewController *)vc
{
    _bgView = [[UIView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    _bgView.backgroundColor = [UIColor blackColor];
    _bgView.userInteractionEnabled = YES;
    _bgView.alpha = 0.3f;
    [vc.view addSubview:_bgView];
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(0,SCREENSIZE.height + frame.size.height, SCREENSIZE.width, frame.size.height);
    [vc.view addSubview:self];
    [UIView animateWithDuration:0.5f
                     animations:^{
                         
                         self.frame = frame;
                     }
                     completion:nil];
}

- (void)hide
{
    [_bgView removeFromSuperview];
    [self removeFromSuperview];
    
}

/**
 *  日期选择的PickView
 *
 *  @param title 标题
 */
- (void)setDateViewWithTitle:(NSString *)title
{
    isDate = YES;
    proTitleList = @[];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 39.5)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENSIZE.width - 80, 39.5)];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [self getColor:@"FF8000"];
    titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    [header addSubview:titleLbl];
    
    
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 50, 10, 50 ,29.5)];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor whiteColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50 ,29.5)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [cancel addTarget:self action:@selector(cancelPick:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:cancel];
    
    [self addSubview:header];
    
    // 1.日期Picker
    UIDatePicker *datePickr = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, 270)];
    datePickr.backgroundColor = [UIColor whiteColor];
    // 1.1选择datePickr的显示风格
    [datePickr setDatePickerMode:UIDatePickerModeDate];
    
    // 1.2查询所有可用的地区
    //NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    
    // 1.3设置datePickr的地区语言, zh_Han后面是s的就为简体中文,zh_Han后面是t的就为繁体中文
    [datePickr setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    
    // 1.4监听datePickr的数值变化
    [datePickr addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSDate *date = [NSDate date];
    
    // 2.3 将转换后的日期设置给日期选择控件
    [datePickr setDate:date];
    
    [self addSubview:datePickr];
    
#pragma -mark self.view的高度，可以自由调节
    
    float height = 300;
    self.frame = CGRectMake(0, SCREENSIZE.height - height, SCREENSIZE.width, height);
}
- (void)setDataViewWithItem:(NSArray *)items title:(NSString *)title
{
    isDate = NO;
    proTitleList = items;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 39.5)];
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREENSIZE.width - 80, 39.5)];
    titleLbl.text = title;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [self getColor:@"FF8000"];
    titleLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.0];
    [header addSubview:titleLbl];
    
    
    
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 50, 10, 50 ,29.5)];
    [submit setTitle:@"确定" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1] forState:UIControlStateNormal];
    submit.backgroundColor = [UIColor whiteColor];
    submit.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50 ,29.5)];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    cancel.backgroundColor = [UIColor whiteColor];
    cancel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
    [cancel addTarget:self action:@selector(cancelPick:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:cancel];
    
    [self addSubview:header];
    UIPickerView *pick = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREENSIZE.width, 270)];
    
    pick.delegate = self;
    pick.backgroundColor = [UIColor whiteColor];
    [self addSubview:pick];
    
    
//    float height = 300;
    self.frame = CGRectMake(0, SCREENSIZE.height - SELF_HEIGHT, SCREENSIZE.width, SELF_HEIGHT);
}

#pragma mark DatePicker监听方法
- (void)dateChanged:(UIDatePicker *)datePicker
{
    // 1.要转换日期格式, 必须得用到NSDateFormatter, 专门用来转换日期格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 1.1 先设置日期的格式字符串
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 1.2 使用格式字符串, 将日期转换成字符串
    selectedStr = [formatter stringFromDate:datePicker.date];
}

- (void)cancelPick:(UIButton *)btn
{
    [self hide];
    
}

- (void)submit:(UIButton *)btn
{
    NSString *pickStr          = selectedStr;
    if (!pickStr || pickStr.length == 0) {
        if(isDate) {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
    selectedStr                = [formatter stringFromDate:[NSDate date]];
        } else {
            if([proTitleList count] > 0) {
    selectedStr                = proTitleList[0];
            }

        }



    }

    block(selectedStr);
    [self hide];


}

// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    return [proTitleList count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    return 180;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    selectedStr = [proTitleList objectAtIndex:row];
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    [self clearSpearatorLine];
    return [proTitleList objectAtIndex:row];
    
}
- (UIColor *)getColor:(NSString*)hexColor

{
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    
}

- (CGSize)workOutSizeWithStr:(NSString *)str andFont:(NSInteger)fontSize value:(NSValue *)value{
    CGSize size;
    if (str) {
        NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];
        size=[str boundingRectWithSize:[value CGSizeValue] options:NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    }
    return size;
}

- (void)returnString:(VVPickViewSubmit)blockString
{
    self.block = blockString;
}
#pragma -mark 去除分割线
- (void)clearSpearatorLine
{
    for (UIView *subViewPick in self.subviews)
    {
        if ([subViewPick isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *subViewLine in subViewPick.subviews)
            {
                if (subViewLine.frame.size.height < 1)//取出分割线view
                {
                    subViewLine.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}
@end
