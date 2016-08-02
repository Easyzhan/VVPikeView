//
//  VVPickView.h
//  VVPicker
//
//  Created by Vizard on 16/7/28.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^VVPickViewSubmit)(NSString* str);

@interface VVPickView : UIView<UIPickerViewDelegate>

/** 背景带阴影的view */
@property(nonatomic, strong) UIView *bgView;

- (void)setDateViewWithTitle:(NSString *)title;

- (void)setDataViewWithItem:(NSArray *)items title:(NSString *)title;

- (void)showPickView:(UIViewController *)vc;

@property(nonatomic,copy)VVPickViewSubmit block;

- (void)returnString:(VVPickViewSubmit)blockString;

@end
