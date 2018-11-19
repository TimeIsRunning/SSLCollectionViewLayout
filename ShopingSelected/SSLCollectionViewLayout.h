//
//  SSLCollectionViewLayout.h
//  ShopingSelected
//
//  Created by 刘松松 on 2018/11/16.
//  Copyright © 2018年 刘松松. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SSLCollectionViewLayoutDelegate <NSObject>
@optional;
-(CGFloat)heightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)heightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)collectionView:(UICollectionView *)collectionView wideForItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface SSLCollectionViewLayout : UICollectionViewLayout
//item 的高度
@property (nonatomic,assign) CGFloat  itemHeight ;
//item左右的间距
@property (nonatomic,assign) CGFloat  itemLRSpace;
@property (nonatomic, assign) UIEdgeInsets sectionEdge;
@property (nonatomic, assign) CGFloat collectionViewWidth;
//item上下的间距
@property (nonatomic,assign) CGFloat  itemHVSpace;
@property (nonatomic, assign) id<SSLCollectionViewLayoutDelegate>delegate;
@end


NS_ASSUME_NONNULL_END
