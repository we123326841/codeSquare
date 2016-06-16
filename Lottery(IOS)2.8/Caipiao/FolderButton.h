//
//  FolderButton.h
//  Caipiao
//
//  Created by danal on 13-1-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FolderView : UIView{
    id _target;
    SEL _selector;
}
@property (assign, nonatomic) int selectedIndex;
@property (strong, nonatomic) NSArray *items;
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)setSelectorForItemClick:(SEL)selector target:(id)target;
@end


@interface FolderButton : UIControl {
    BOOL _opened;
    CGRect _origFrame;
    UIImageView *_arrow;
    UIView *_maskView;
}
@property (assign, nonatomic) int selectedIndex;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) FolderView *folderView;
@end
