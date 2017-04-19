//
//  CustomWaterfallLayout.m
//  瀑布流
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "CustomWaterfallLayout.h"


@interface CustomWaterfallLayout ()
//用来记录每一列的最大y值
@property (nonatomic, strong) NSMutableDictionary *maxYDic;
//保存每一个item的attributes
@property (nonatomic, strong) NSMutableArray *attributesArray;
@end


@implementation CustomWaterfallLayout

#pragma mark- 懒加载
- (NSMutableDictionary *)maxYDic {
    if (!_maxYDic) {
        _maxYDic = [[NSMutableDictionary alloc] init];
    }
    return _maxYDic;
}

- (NSMutableArray *)attributesArray {
    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

#pragma mark- 构造方法
- (instancetype)init {
    if (self = [super init]) {
        self.columnCount = 2;
    }
    return self;
}

- (instancetype)initWithColumnCount:(NSInteger)columnCount {
    if (self = [super init]) {
        self.columnCount = columnCount;
    }
    return self;
}

+ (instancetype)waterFallLayoutWithColumnCount:(NSInteger)columnCount {
    return [[self alloc] initWithColumnCount:columnCount];
}

#pragma mark- 相关设置方法
- (void)setColumnSpacing:(NSInteger)columnSpacing rowSpacing:(NSInteger)rowSepacing sectionInset:(UIEdgeInsets)sectionInset {
    self.columnSpacing = columnSpacing;
    self.rowSpacing = rowSepacing;
    self.sectionInset = sectionInset;
}

#pragma mark- 布局相关方法
//布局前的准备工作
- (void)prepareLayout {
    [super prepareLayout];
    //初始化字典，有几列就有几个键值对，key为列，value为列的最大y值，初始值为上内边距
    for (int i = 0; i < self.columnCount; i++) {
        self.maxYDic[@(i)] = @(self.sectionInset.top);
        
//        [self.maxYDic objectForKey:[self.maxYDic.allKeys objectAtIndex:i]] = self.sectionInset.top ;
    }
    
    //根据collectionView获取总共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    [self.attributesArray removeAllObjects];

    //为每一个item创建一个attributes并存入数组
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attributesArray addObject:attributes];
    }
}

//计算collectionView的contentSize
- (CGSize)collectionViewContentSize {
    __block NSNumber *maxIndex = @0;
    //遍历字典，找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[maxIndex] floatValue] < obj.floatValue) {
            maxIndex = key;
        }
    }];
    
    //collectionView的contentSize.height就等于最长列的最大y值+下内边距
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInset.bottom);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //根据indexPath获取item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //获取collectionView的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    
    //item的宽度 = (collectionView的宽度 - 内边距与列间距) / 列数
    CGFloat itemWidth = (collectionViewWidth - self.sectionInset.left - self.sectionInset.right - (self.columnCount - 1) * self.columnSpacing) / self.columnCount;
    
    CGFloat itemHeight = 0;
    //获取item的高度，由外界计算得到
    if (self.itemHeightBlock) itemHeight = self.itemHeightBlock(itemWidth, indexPath);
    else {
        if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)])
            itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
    }
    
    //找出最短的那一列
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
        if ([self.maxYDic[minIndex] floatValue] > obj.floatValue) {
            minIndex = key;
        }
    }];
    
    //根据最短列的列数计算item的x值
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex.integerValue;
    
    //item的y值 = 最短列的最大y值 + 行间距
    CGFloat itemY = [self.maxYDic[minIndex] floatValue] + self.rowSpacing;
    
    //设置attributes的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    
    //更新字典中的最大y值
    self.maxYDic[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}

//返回rect范围内item的attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArray;
}




//- (NSMutableDictionary *)maxYDict
//{
//    if (!_maxYDict) {
//        
//        self.maxYDict = [[NSMutableDictionary alloc] init];
//    }
//    return _maxYDict;
//}
//
//- (NSMutableArray *)attributeArray
//{
//    if (!_attributeArray) {
//        self.attributeArray = [[NSMutableArray alloc] init];
//    }
//    return _attributeArray;
//}
//
//#pragma mark -初始化默认值
//- (instancetype)init
//{
//    if (self = [super init]) {
//        self.columnMargin = 15;
//        self.rowMargin = 10;
//        self.columnsCount = 3;
//        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    }
//    return self;
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}
//
//// 布局每一个indexPath的位置
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 1.计算尺寸
//    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin) / self.columnsCount;
//    // 代理计算传入高的值
//    CGFloat height = [self.delegate flowLayout:self heightForWidth:width atIndexPath:indexPath];
//    
//    // 2.0假设最短的那一列的第0列
//    __block NSString *minColumn = @"0";
//    // 遍历字典找出最短的那一列
//    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
//        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
//            minColumn = column;
//        }
//    }];
//    
//    // 2.1计算位置
//    CGFloat x = self.sectionInset.left + (self.columnMargin + width) * [minColumn intValue];
//    CGFloat y = [self.maxYDict[minColumn] floatValue]+ _rowMargin;
//    
//    self.maxYDict[minColumn] = @(y + height);
//    // 3.创建属性
//    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    attrs.frame = CGRectMake(x, y, width, height);
//    return attrs;
//}
//
//- (void)prepareLayout
//{
//    [super prepareLayout];
//    // 1.清空最大的Y值
//    for (int i = 0; i<self.columnsCount; i++) {
//        NSString *column = [NSString stringWithFormat:@"%d", i];
//        self.maxYDict[column] = @(self.sectionInset.top);
//    }
//    [self.attributeArray removeAllObjects];
//    
//    // 总 item 数
//    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//    for (int i = 0; i <count; i++) {
//        UICollectionViewLayoutAttributes *attris = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        [self.attributeArray addObject:attris];
//    }
//    
//}
//
//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    
//    return self.attributeArray;
//}
//
//// 计算ContentSize
//- (CGSize)collectionViewContentSize
//{
//    // 默认最大Y值在第0列
//    __block NSString *maxColumn = @"0";
//    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
//        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
//            maxColumn = column;
//        }
//    }];
//    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);
//    
//}
@end
