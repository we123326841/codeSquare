//
//  FavoriteCell.m
//  Caipiao
//
//  Created by danal on 13-1-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        float mar = 5.f, w = (self.bounds.size.width - 2*mar)/2, h = 17.f;
        CGRect rect = CGRectMake(mar, mar, w, h);
        {
            UILabel *typeLbl = [[UILabel alloc] initWithFrame:rect];
            typeLbl.text = @"重庆时时彩";
            typeLbl.font = [UIFont boldSystemFontOfSize:14.f];
            [self.contentView addSubview:typeLbl];
            [typeLbl release];
        }
        {
            rect.origin.x += w;
            UILabel *amountLbl = [[UILabel alloc] initWithFrame:rect];
            amountLbl.font = [UIFont boldSystemFontOfSize:14.f];
            amountLbl.text = @"6.00元";
            [self.contentView addSubview:amountLbl];
            [amountLbl release];
        }

        {
            rect.origin.x = mar;
            rect.origin.y = mar + h;
            UILabel *subtypeLbl = [[UILabel alloc] initWithFrame:rect];
            subtypeLbl.font = [UIFont boldSystemFontOfSize:12.f];
            subtypeLbl.text = @"混合";
            [self.contentView addSubview:subtypeLbl];
            [subtypeLbl release];
        }

        {
            rect.origin.x += w;
            UILabel *dateLbl = [[UILabel alloc] initWithFrame:rect];
            dateLbl.font = [UIFont boldSystemFontOfSize:12.f];
            dateLbl.text = @"2012-11-15 12：13";
            [self.contentView addSubview:dateLbl];
            [dateLbl release];
        }
        for (UIView *v in self.contentView.subviews){
            if ([v isKindOfClass:[UILabel class]]){
                UILabel *lbl = (UILabel *)v;
                lbl.backgroundColor = self.backgroundColor;
                lbl.textColor = kWhiteTextColor;
            }

        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//    UIImage *middle = [UIImage imageNamed:@"common_list_yellow_bg.png"];
//    [middle drawInRect:CGRectInset(rect, 10.f, 0.f)];
//}

@end
