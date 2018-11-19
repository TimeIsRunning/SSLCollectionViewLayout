//
//  SSLCollectionViewLayout.m
//  ShopingSelected
//
//  Created by 刘松松 on 2018/11/16.
//  Copyright © 2018年 刘松松. All rights reserved.
//

#import "SSLCollectionViewLayout.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define kBaseLine(a) (CGFloat)a * SCREEN_WIDTH / 375.0
@interface SSLCollectionViewLayout ()
@property (nonatomic, assign) CGFloat totalHeight; ///总高度
@property (nonatomic, assign) CGFloat itemX;//单元格的x
@property (nonatomic, strong) NSMutableArray *attrsArr; /// item布局属性数组
@property (nonatomic, assign) NSInteger currentSection;
@end
@implementation SSLCollectionViewLayout
-(void)prepareLayout {
    [super prepareLayout];
    self.totalHeight = 0;
    NSMutableArray *attributesArr = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:i];
        /// header布局
        if (self.delegate && [self.delegate respondsToSelector:@selector(heightOfSectionHeaderForIndexPath:)])
        {
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexP];
            [attributesArr addObject:attr];
        }
        /// item布局
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView: wideForItemAtIndexPath:)])
        {
            NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
            for (int j = 0; j < itemCount; j++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
                UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
                [attributesArr addObject:attrs];
            }
        }
        /// footer布局
        if (self.delegate && [self.delegate respondsToSelector:@selector(heightOfSectionFooterForIndexPath:)])
        {
            UICollectionViewLayoutAttributes *attr1 = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexP];
            [attributesArr addObject:attr1];
        }
    }
    self.attrsArr = [NSMutableArray arrayWithArray:attributesArr];
}
/// contentSize
-(CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, self.totalHeight + self.sectionEdge.bottom);
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    CGFloat height = 0;
    self.itemX = self.sectionEdge.left;
    
    if (elementKind == UICollectionElementKindSectionHeader) {
        if (layoutAttrs.indexPath.section >0)
        {
            self.totalHeight += self.itemHeight;
            self.totalHeight = self.totalHeight + self.sectionEdge.bottom;
        }
        
        CGFloat itemY = self.totalHeight;
        if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionHeaderForIndexPath:)]) {
            height = [_delegate heightOfSectionHeaderForIndexPath:indexPath];
            self.totalHeight += height;
            layoutAttrs.frame = CGRectMake(0, itemY, self.collectionView.frame.size.width, height);
        }
        self.totalHeight = self.totalHeight + self.sectionEdge.top;
    } else {
        CGFloat itemY = self.totalHeight;
        if (_delegate != nil && [_delegate respondsToSelector:@selector(heightOfSectionFooterForIndexPath:)]) {
            height = [_delegate heightOfSectionFooterForIndexPath:indexPath];
            self.totalHeight += height;
            layoutAttrs.frame = CGRectMake(0, itemY, self.collectionView.frame.size.width, height);
        }
        
    }
    return layoutAttrs;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat W = 30+ arc4random_uniform(50);
    
    
    if ([self.delegate respondsToSelector:@selector(collectionView:wideForItemAtIndexPath:)])
    {
        W = [self.delegate collectionView:self.collectionView wideForItemAtIndexPath:indexPath];
    }
    
    if (self.itemX + W > self.collectionView.frame.size.width - self.sectionEdge.left - self.sectionEdge.right)
    {
        self.totalHeight = self.totalHeight + self.itemHeight + self.itemHVSpace;
        self.itemX = self.sectionEdge.left;
        
    }
   CGFloat itemY = self.totalHeight;
    layoutAttributes.frame = CGRectMake(self.itemX, itemY , W, self.itemHeight);
    self.itemX = self.itemX + W + self.itemLRSpace;
    
    return layoutAttributes;
}

@end
