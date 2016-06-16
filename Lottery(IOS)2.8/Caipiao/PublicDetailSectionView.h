//
//  PublicDetailSectionView.h
//  Caipiao
//
//  Created by CYRUS on 14-8-5.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PublicDetailSectionViewDelegate;

@interface PublicDetailSectionView : UIView

@property (assign, nonatomic) IBOutlet UIImageView *arrow;
@property (assign, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (assign, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) BOOL opened;
@property (nonatomic, assign) id <PublicDetailSectionViewDelegate> delegate;

@end

@protocol PublicDetailSectionViewDelegate <NSObject>

@optional
- (void)sectionHeaderView:(PublicDetailSectionView *)sectionHeaderView sectionClosed:(NSInteger)section;

- (void)sectionHeaderView:(PublicDetailSectionView *)sectionHeaderView sectionOpened:(NSInteger)section;

@end