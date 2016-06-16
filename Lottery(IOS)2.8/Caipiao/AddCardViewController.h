//
//  AddCardViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-11-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
@class DropDownBoxBlack;
@class RoundedBlackView;

@interface AddCardViewController : BaseViewController
{
    IBOutlet UIView             *_warpView;
    IBOutlet UIImageView        *_gridView;
    
    IBOutlet UIButton           *_bankField;
    IBOutlet UIButton           *_provinceField;
    IBOutlet UIButton           *_cityField;
    
    IBOutlet UITextField        *_bankAccountField;
    IBOutlet UITextField        *_branchField;
    IBOutlet UITextField        *_accountNameField;
    IBOutlet UITextField        *_nameField;
    
    IBOutletCollection(UILabel) NSArray *_lbl6s;
    IBOutletCollection(UILabel) NSArray *_lbl9s;
}

- (IBAction)submitAction:(id)sender;
- (IBAction)onBankAction:(id)sender;
- (IBAction)onProvinceAction:(id)sender;
- (IBAction)onCityAction:(id)sender;

@end

#import "DropDownSelector.h"
#import "SheetPicker.h"
