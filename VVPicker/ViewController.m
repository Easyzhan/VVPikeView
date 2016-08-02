//
//  ViewController.m
//  VVPicker
//
//  Created by Vizard on 16/7/28.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import "ViewController.h"
#import "VVPickView.h"

@interface ViewController ()
{
    BOOL selected;
}

/** PickView */
@property(nonatomic, strong) VVPickView *pickView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ChoiceReason:(id)sender {
    selected = !selected;
   
    if (selected) {
        self.pickView = [[VVPickView alloc] init];
        
        [self.pickView setDataViewWithItem:@[@"客户不缺货",@"下多了",@"仓库缺货", @"下错了",@"下的价格不对"] title:@""];
        
        [self.pickView showPickView:self];
        
//        __weak typeof(self) weakSelf = self;
        
//        self.pickView.block = ^(NSString *selectedStr)
//        {
//            
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have chooseed:" message:selectedStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            
//        };
//----------------------------------------------------------------------------------------------------------------------
        [self.pickView returnString:^(NSString *str) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have chooseed:" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
        }];
//----------------------------------------------------------------------------------------------------------------------
    }else{
    VVPickView *vPicker = [VVPickView new];
    [self.view addSubview:vPicker];
    [vPicker setDateViewWithTitle:@"bigMoM"];
    [vPicker showPickView:self];
//----------------------------------------------------------------------------------------------------------------------
//    vPicker.block = ^(NSString *str){
//    
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have chooseed:" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//    };
//----------------------------------------------------------------------------------------------------------------------
        [vPicker returnString:^(NSString *str) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have chooseed:" message:str delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
        
//----------------------------------------------------------------------------------------------------------------------
    }
}

@end
