//
//  NewCollectionViewCell.h
//  瀑布流
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *currentImg;
@property (nonatomic, strong) NSURL *strImgURL;
@end
