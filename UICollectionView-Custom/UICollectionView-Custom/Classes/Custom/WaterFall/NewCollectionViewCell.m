//
//  NewCollectionViewCell.m
//  瀑布流
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "NewCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation NewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setStrImgURL:(NSURL *)strImgURL

{
    _strImgURL = strImgURL ;
    [self.currentImg sd_setImageWithURL:strImgURL placeholderImage:[UIImage imageNamed:@"img"]] ;
}
@end
