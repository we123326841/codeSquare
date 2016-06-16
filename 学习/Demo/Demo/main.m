//
//  main.m
//  Demo
//
//  Created by 王浩 on 16/3/11.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
float changeFloat(float oldFloat,int precisionLength);
int main(int argc, const char * argv[]) {
//    int i = 0;
//    int b =32;
//    int c =3;
//    
//    i = b =c;
//    NSLog(@"%d %d %d",i,b,c);
//    
//    if ((i= 3*3)) {
//        NSLog(@"得得");
//    }
    int i =0;
    do{
        i++;
    
    }while(i<100);
    NSLog(@"%d",i);
//    NSString *to =@"13.3";
//    double too =[to doubleValue];
//    NSDecimalNumber *num=[NSDecimalNumber decimalNumberWithString:to];
//    float de=[num floatValue];
//   float d= changeFloat(13.322, 3);
    
    
    double spd = 22.518744;
    spd=( (double)( (int)( (spd+0.005)*100 ) ) )/100;
    
    return 0;
}

//float changeFloat(float oldFloat,int precisionLength) {
//    return ((int)((oldFloat-(int)oldFloat)*square(precisionLength)))/(float)square(precisionLength) + (int)oldFloat;
//}

