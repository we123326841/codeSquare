//
//  TabBarView.m
//  Caipiao
//
//  Created by 王浩 on 15/10/16.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "TabBarView.h"
@interface TabBarView()

@property (nonatomic,assign)int btn_Index;
@property(nonatomic,assign) int uv_Index;
@end

@implementation TabBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor =[UIColor colorWithRed:241/255.0 green:  241/255.0 blue:241/255.0 alpha:1.0];
        
//        self.backgroundColor=[UIColor redColor];
        [self addChildBtn];
        [self addlines];
            }
    
    
    return  self;

}



-(void)addChildBtn{
    UIButton *register1=[[UIButton alloc] init];
    register1.tag =0;
    self.register1 =register1;
    [register1 setTitle:@"未注册" forState:UIControlStateNormal];
    [register1 setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
    [register1 setTitleColor:[UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1.0] forState:UIControlStateDisabled];
    
    register1.titleLabel.font=[UIFont systemFontOfSize:12];
    [register1 setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    [register1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *modifi_remarks=[[UIButton alloc] init];
    modifi_remarks.tag =1;
    [modifi_remarks setTitle:@"修改备注" forState:UIControlStateNormal];
    [modifi_remarks setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
     [modifi_remarks setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    
    modifi_remarks.titleLabel.font=[UIFont systemFontOfSize:12];
    [modifi_remarks addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *delete_link=[[UIButton alloc] init];
    delete_link.tag =2;
    [delete_link setTitle:@"删除链接" forState:UIControlStateNormal];
      [delete_link setTitleColor:[UIColor colorWithRed:119/255.0 green:119/255.0 blue:119/255.0 alpha:1.0] forState:UIControlStateNormal];
    [delete_link setTitleColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0] forState:UIControlStateHighlighted];

    
    
    delete_link.titleLabel.font=[UIFont systemFontOfSize:12];
    [delete_link addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [self addSubview:register1];
    [self addSubview:modifi_remarks];
    [self addSubview:delete_link];
    
    

}


-(void)addlines{
    UIView *line1 =[[UIView alloc]init];
    line1.backgroundColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
    [self addSubview:line1];
    
    
    UIView *line2 =[[UIView alloc]init];
    line2.backgroundColor =[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
    [self addSubview:line2];

}


-(void)click:(UIButton*)btn{
    //NSLog(@"点击%ld",(long)btn.tag);
    if([self.delegate respondsToSelector:@selector(tabBarViewBtnClick:)]){
        [self.delegate tabBarViewBtnClick:btn];
    
    }
    
}


-(void)layoutSubviews{
    [super layoutSubviews ];
    CGFloat count=self.subviews.count ;
    CGFloat width =self.width/3;
    CGFloat y =0;
    int btn_Index=0;
    int uv_Index=0;
    for (int i =0 ; i<count; i++) {
//        CGFloat x =width*i;
//        UIButton *btn=self.subviews[i];
//        btn.frame =CGRectMake(x, y, width, self.height);
        if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
            CGFloat x =btn_Index*width;
                    UIButton *btn=self.subviews[i];
                   btn.frame =CGRectMake(x, y, width, self.height);
            btn_Index++;
            
        }else{
            CGFloat x =(uv_Index+1)*width;
            UIView *uv =self.subviews[i];
            uv.frame =CGRectMake(x, y, 0.5, self.height);
            uv_Index++;
        }
    }

}


@end
