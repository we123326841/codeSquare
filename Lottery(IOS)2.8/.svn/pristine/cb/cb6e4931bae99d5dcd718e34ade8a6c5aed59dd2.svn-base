//
//  HigherNumTableViewCell.m
//  Caipiao
//
//  Created by 王浩 on 15/11/19.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "HigherNumTableViewCell.h"

#import "NumberPad.h"
@interface HigherNumTableViewCell()
@property(nonatomic,weak)KeyBoardAccess*access;
@end
@implementation HigherNumTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //UIView *vie= [[UIView alloc]init];
      _textField.inputView =[NumberPad instance];
   // _textField.inputView =vie;
    KeyBoardAccess *access=[KeyBoardAccess keyBoard];
    _textField.inputAccessoryView=access;
    _textField.cell=self;
    self.access =access;
//    _textField.delegate =self;
    access.delegate=self;
//    _textField.inputAccessoryView =self;
//
   // [_textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidecomplete:) name:UIKeyboardDidHideNotification object:nil];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self =[super initWithCoder:aDecoder]) {
        

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HigherChaseModel *)model{
    _model =model;
    _serialNumLabel.text =model.serialNumber;
    _issueLabel.text =model.issueNumber;
    _textField.text =model.beiShuNumber;
    [_textField addTarget:self action:@selector(limitInputShuzi:) forControlEvents:UIControlEventEditingChanged];
    _totalLabel.text =model.totalNumber;
    _payOffLabel.text =model.payOffNumber;
    _payOffRateLabel.text=model.payOffRate;
    _access.beiTouLimit.text =[NSString stringWithFormat:@"  倍投上线: %@",model.beiTouLimit];
    _access.methodName.text =[NSString stringWithFormat:@"  方案玩法: %@",model.methodName];

}

-(void)textFieldValueChange:(UITextField*)textField{
    NSLog(@"---%@",textField.text);
}

-(void)keyBoardAccess:(KeyBoardAccess *)access DidSubBtnClick:(UIButton *)subClick{
   int value= [_textField.text intValue];
    value--;
    if (value<=0) {
        value=1;
    }
    
    _textField.text=[NSString stringWithFormat:@"%d",value];

}


-(void)keyBoardAccess:(KeyBoardAccess *)access DidAddBtnClick:(UIButton *)addClick{
    int value= [_textField.text intValue];
    value++;
    if(value>=[_model.beiTouLimit intValue]){
        value=[_model.beiTouLimit intValue];
    }
    _textField.text=[NSString stringWithFormat:@"%d",value];

}

-(void)limitInputShuzi:(UITextField*)textFiled{
    
    if (textFiled.text.length ==0) {
        //textFiled.text=@"1";
        return;
    }
    
    if ([textFiled.text doubleValue]>=[_model.beiTouLimit intValue]) {
        textFiled.text =_model.beiTouLimit;
    }
//    if ([self.delegate respondsToSelector:@selector(tableViewCell:textFieldDidChange:)]) {
//        [self.delegate tableViewCell:self textFieldDidChange:[textFiled.text intValue]];
//    }

}


//-(void)keyboardDidHidecomplete:(NSNotification*)noti{
//    NSLog(@"de");
//}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"43434343");
//    return  [self textFieldShouldReturn:textField];
//}



-(void)dealloc{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
