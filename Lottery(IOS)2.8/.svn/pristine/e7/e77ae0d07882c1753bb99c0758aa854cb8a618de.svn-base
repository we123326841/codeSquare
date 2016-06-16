//
//  HigherChaseViewCell.m
//  ZhuihaoDemo
//
//  Created by 王浩 on 15/11/30.
//  Copyright © 2015年 王浩. All rights reserved.
//

#import "HigherChaseViewCell.h"
#import "NumberPad.h"
#define HMMAX_VALUE 99999
@interface HigherChaseViewCell()

@end
@implementation HigherChaseViewCell

- (void)awakeFromNib {
    // Initialization code
    _textField1.inputView =[NumberPad instance];
    [_textField1 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField11.inputView =[NumberPad instance];
    [_textField11 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField2.inputView =[NumberPad instance];
    [_textField2 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField22.inputView =[NumberPad instance];
    [_textField22 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField3.inputView =[NumberPad instance];
    [_textField3 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField33.inputView =[NumberPad instance];
    [_textField33 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField333.inputView =[NumberPad instance];
    [_textField333 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField4.inputView =[NumberPad instance];
    [_textField4 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField44.inputView =[NumberPad instance];
    [_textField44 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _textField444.inputView =[NumberPad instance];
    [_textField444 addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
  //  _btn1.selected =YES;
}

-(NSMutableArray*)btns{
    if (_btns==nil) {
        _btns=[NSMutableArray array];
        [_btns addObject:_btn1];
        [_btns addObject:_btn2];
        [_btns addObject:_btn3];
        [_btns addObject:_btn4];
    }
    return _btns;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)checkBoxClick:(UIButton *)sender {
    for (UIButton*btn in self.btns) {
        if (btn==sender) {
            if (!btn.selected) {
                
                btn.selected =!btn.isSelected;
            }
        }else{
            btn.selected =NO;
        }
    }
    
    
}


-(void)limitInputShuzi:(UITextField*)textField{
    if ([textField.text doubleValue]>HMMAX_VALUE) {
        HUDShowMessageforView(@"返点超出上限", nil);
        textField.text=[NSString stringWithFormat:@"%d",HMMAX_VALUE];
        
    }


}


//- (void)dealloc {
//    [_textField1 release];
//    [_textField11 release];
//    [_textField2 release];
//    [_textField22 release];
//    [_textField3 release];
//    [_textField33 release];
//    [_textField333 release];
//    [_textField4 release];
//    [_textField44 release];
//    [_textField444 release];
//  [super dealloc];
//}


@end
