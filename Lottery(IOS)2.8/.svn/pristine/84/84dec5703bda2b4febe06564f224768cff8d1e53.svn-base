//
//  MSLoadingCell.m
//  Musou
//
//  Created by luo danal on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSLoadingCell.h"

@implementation MSLoadingCell
@synthesize delegate = _delegate;
@synthesize indicator = _indicator;
@synthesize tipButton = _tipButton;
@synthesize type = _type;
@synthesize state = _state;

- (void)dealloc{
    [_indicator release]; _indicator = nil;
    [_tipButton release]; _tipButton = nil;
    [super dealloc];
}

- (id)initWithType:(MSLoadingCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.type = type;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.center = CGPointMake(70/2, 44/2);
        [self.contentView addSubview:_indicator];
        
        UIButton *button = nil;
        if (type == MSLoadingCellTypeTapToLoad) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:NSLocalizedString(@"点击加载更多", nil) forState:UIControlStateNormal];
        } else {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:NSLocalizedString(@"加载更多", nil) forState:UIControlStateNormal];
        }
        button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(startLoad) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(70, 4, 200, 36);
        self.tipButton = button;
        [self.contentView addSubview:self.tipButton];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (self.type == MSLoadingCellTypeAutoLoad) {
        [self startLoad];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.bounds;
    _indicator.center = CGPointMake(70/2, rect.size.height/2);
    _tipButton.frame = CGRectMake(70, (rect.size.height - 36)/2, rect.size.width - 2*70, 36);
}

- (void)startLoad{
    [_indicator startAnimating];
    [self.tipButton setTitle:NSLocalizedString(@"加载中...", nil) forState:UIControlStateNormal];
    self.state = MSLoadingCellStateLoading;
    if (_delegate && [_delegate respondsToSelector:@selector(loadingCellDidStartLoading:)]) {
        [_delegate loadingCellDidStartLoading:self];
    }
}

- (void)stopLoad{
    [_indicator stopAnimating];
    self.state = MSLoadingCellStateNormal;
    if (self.type == MSLoadingCellTypeTapToLoad) {
        [self.tipButton setTitle:NSLocalizedString(@"点击加载更多", nil) forState:UIControlStateNormal];
    } else {
        [self.tipButton setTitle:NSLocalizedString(@"加载更多", nil) forState:UIControlStateNormal];
    }
}

- (void)setState:(MSLoadingCellState)state{
    if (self.type == MSLoadingCellTypeReleaseToLoad) {
        if (_state != state) {
            _state = state;
            if (_state == MSLoadingCellStateNormal) {
                [self.tipButton setTitle:NSLocalizedString(@"加载更多", nil) forState:UIControlStateNormal];        
            } else if (_state == MSLoadingCellStateReadyToLoad){
                [self.tipButton setTitle:NSLocalizedString(@"释放加载更多", nil) forState:UIControlStateNormal];
            }
        }
    }
}

@end
