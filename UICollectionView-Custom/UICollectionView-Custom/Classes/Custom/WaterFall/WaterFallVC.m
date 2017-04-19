//
//  WaterFallVC.m
//  UICollectionView-Custom
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "WaterFallVC.h"
#import "CustomWaterfallLayout.h"
#import "NewCollectionViewCell.h"
#import "ImageModel.h"

@interface WaterFallVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong)UICollectionView *collectionView ;
@property (nonatomic, strong) NSMutableArray<ImageModel *> *imgArr;
@end

@implementation WaterFallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"瀑布流图片";
    [self.view addSubview:self.collectionView] ;
}

// 懒加载
-(NSMutableArray<ImageModel *> *)imgArr
{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array] ;
        NSString *strPath = [[NSBundle mainBundle]pathForResource:@"1.plist" ofType:nil] ;
        NSArray *arrPath = [NSArray arrayWithContentsOfFile:strPath] ;
        for (NSDictionary *dic in arrPath) {
            ImageModel *imgM = [ImageModel imageWithImageDic:dic] ;
            [_imgArr addObject:imgM] ;
        }
    }
    return _imgArr ;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        //初始化
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds    collectionViewLayout:[self customWaterfallLayout]] ;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.collectionView registerNib:[UINib nibWithNibName:@"NewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        self.collectionView.dataSource = self;
    }
    return _collectionView ;
}
-(UICollectionViewLayout *)customWaterfallLayout
{
    // 布局类
    CustomWaterfallLayout *layout = [CustomWaterfallLayout waterFallLayoutWithColumnCount:3] ;
    
    //行间距，列艰巨，内边距
    [layout setColumnSpacing:10 rowSpacing:10 sectionInset:UIEdgeInsetsMake(10, 10, 10, 10)] ;
    
    // 传入图片的高度
    [layout setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath){
        ImageModel *imgM = self.imgArr[indexPath.item] ;
       return  imgM.imageH /imgM.imageW *itemWidth ;
    }] ;
    
    return layout ;
}

#pragma mark - UICollectionView 数据源协议

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imgArr.count ;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.strImgURL = self.imgArr[indexPath.item].imgURL;
    return cell;
}



@end
