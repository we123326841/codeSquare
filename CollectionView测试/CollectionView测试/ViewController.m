//
//  ViewController.m
//  CollectionView测试
//
//  Created by 王浩 on 16/4/18.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "GifHeader.h"
@interface ViewController ()
@property(nonatomic,weak)UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView =[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    GifHeader *header=[GifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    header.gifView.frame = CGRectMake(0, 100, 100, 100);
    _collectionView = collectionView;
    collectionView.mj_header = header;

    [self.view addSubview:collectionView];
}

-(void)headRefresh{
    [NSThread sleepForTimeInterval:3];
    [self.collectionView.mj_header endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
