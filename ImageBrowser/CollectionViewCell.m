//
//  CollectionViewCell.m
//  ImageBrowser
//
//  Created by 蜗牛 on 16/9/7.
//  Copyright © 2016年 关于蜗牛：一枚九零后码农  蜗牛-----QQ:3197857495-----李富棚  个人微信：woniu1308822159  微信公众号：woniuxueios  简书：蜗牛学IOS  地址：http://www.jianshu.com/users/a664a9fcb096/latest_articles  简书专题：蜗牛学IOS  地址：http://www.jianshu.com/collection/bfcf49bf5d27    GitHub:https://github.com/LiFuPeng       蜗牛     */. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface CollectionViewCell ()

@property (nonatomic,strong) UIImageView * mImageView;

@end

@implementation CollectionViewCell


-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if (self) {
        
        _mImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mImageView.backgroundColor = [UIColor redColor];
        _mImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //        NSString *url=[imageArray[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"3:%@",imageArray[indexPath.row]);
//        [mImageView sd_setImageWithURL:[NSURL URLWithString:imageArray[indexPath.row]]];
        [self addSubview:_mImageView];
    
    }
    return self;

}

-(void)setUrl:(NSString *)url{
    
    _url=url;
    NSString *stringUrl=[_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [_mImageView sd_setImageWithURL:[NSURL URLWithString:stringUrl]];

}


@end
