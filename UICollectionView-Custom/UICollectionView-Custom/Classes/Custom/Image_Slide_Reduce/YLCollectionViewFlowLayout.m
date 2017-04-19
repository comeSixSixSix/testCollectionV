//
//  YLCollectionViewFlowLayout.m
//  UICollectionView-Custom
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "YLCollectionViewFlowLayout.h"

@implementation YLCollectionViewFlowLayout

// 刷新或者初始化更新，默认数据
- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(100, 100);
        self.minimumLineSpacing = 70;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
 
    }
    return self;
}
// 返回yes，每次滚动都刷新属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

// 设置属性
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 1.collectionView 的中心点屏幕中心的X
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attri in array) {
       
        // 通过计算 item 的中心点距离与屏幕中心X的距离计算缩放比例
        CGFloat scale = 1.5 - ABS(attri.center.x - centerX) / self.collectionView.frame.size.width;
        // 缩放
        attri.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

// 设定滚动停留位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // 计算屏幕中心点
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat ajustX = MAXFLOAT;
    // 给定范围
    CGRect rect = {proposedContentOffset,self.collectionView.frame.size};
//     遍历比较所有item的x
    NSArray *array = [self layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attribute in array) {
        if (ABS(attribute.center.x - centerX) < ABS(ajustX)) {
            ajustX = attribute.center.x - centerX;
        }
    }
    return CGPointMake(proposedContentOffset.x + ajustX, proposedContentOffset.y);
}

@end
