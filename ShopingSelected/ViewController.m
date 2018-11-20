//
//  ViewController.m
//  ShopingSelected
//
//  Created by 刘松松 on 2018/11/16.
//  Copyright © 2018年 刘松松. All rights reserved.
//

#import "ViewController.h"
#import "SSLCollectionViewLayout.h"
#import <Masonry.h>
#import "CollectionShopingCollectionViewCell.h"
// 屏幕宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SSLCollectionViewLayoutDelegate>
@property (nonatomic, strong) UICollectionView *colle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    SSLCollectionViewLayout *layout = [[SSLCollectionViewLayout alloc]init];
    layout.sectionEdge = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemHVSpace = 10;
    layout.itemHeight = 30;
    layout.itemLRSpace = 10;
//    layout.collectionViewWidth = SCREEN_WIDTH;
    layout.delegate = self;
    
    self.colle = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.colle.backgroundColor = [UIColor whiteColor];
    self.colle.delegate = self;
    self.colle.dataSource = self;
    [self.colle registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
//    [self.colle registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.colle registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionShopingCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([CollectionShopingCollectionViewCell class])];
    [self.view addSubview:self.colle];
    [self.colle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


- (CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

//- (CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath
//{
//    return  CGFLOAT_MIN;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView wideForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row * 10 + 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        header.backgroundColor = [UIColor blueColor];
        for (UIView *view in header.subviews)
        {
            [view removeFromSuperview];
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        titleLabel.text = @"电视剧";
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [header addSubview:titleLabel];
        return header;
    }
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    footer.backgroundColor = [UIColor orangeColor];
    for (UIView *view in footer.subviews)
    {
        [view removeFromSuperview];
    }
    
//    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
//    titleLabel.text = @"电视剧看过；阿克苏";
//    titleLabel.textColor = [UIColor redColor];
//    titleLabel.font = [UIFont systemFontOfSize:14];
//    [footer addSubview:titleLabel];
    return nil;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionShopingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionShopingCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.backgroundColor = [UIColor purpleColor];
    cell.titleLabel.text = @"gsak;gksa;;ghk;ash";
    
    return cell;
}


@end
