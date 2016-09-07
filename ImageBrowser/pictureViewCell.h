//
//  pictureViewCell.h
//  ImageBrowser
//
//  Created by 蜗牛 on 16/9/7.
//  Copyright © 2016年 关于蜗牛：一枚九零后码农  蜗牛-----QQ:3197857495-----李富棚  个人微信：woniu1308822159  微信公众号：woniuxueios  简书：蜗牛学IOS  地址：http://www.jianshu.com/users/a664a9fcb096/latest_articles  简书专题：蜗牛学IOS  地址：http://www.jianshu.com/collection/bfcf49bf5d27    GitHub:https://github.com/LiFuPeng       蜗牛     */. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pictureViewCell : UICollectionViewCell<UIScrollViewDelegate>

// 图片的url地址
@property (nonatomic,strong) NSString *imageUrlString ;
// 视图
@property (nonatomic,strong) UIImageView *imageView ;

@property (nonatomic,strong) UIScrollView *scrollView ;

@end
