//
//  YLCollectionViewCell.m
//  UICollectionView-Custom
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "YLCollectionViewCell.h"

@interface YLCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation YLCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib] ;
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image
{
    _image = image;
    self.imageView.image = [UIImage imageNamed:image];
}

@end
