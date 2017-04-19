//
//  ImageModel.m
//  瀑布流
//
//  Created by 123 on 2017/4/18.
//  Copyright © 2017年 iPhone. All rights reserved.
//

#import "ImageModel.h"

@implementation ImageModel

+(instancetype)imageWithImageDic:(NSDictionary *)imageDic
{
    ImageModel *image = [[ImageModel alloc] init];
    image.imgURL = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image ;
    
}
@end
