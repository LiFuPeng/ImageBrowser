//
//  pictureViewCell.m
//  ImageBrowser
//
//  Created by 蜗牛 on 16/9/7.
//  Copyright © 2016年 关于蜗牛：一枚九零后码农  蜗牛-----QQ:3197857495-----李富棚  个人微信：woniu1308822159  微信公众号：woniuxueios  简书：蜗牛学IOS  地址：http://www.jianshu.com/users/a664a9fcb096/latest_articles  简书专题：蜗牛学IOS  地址：http://www.jianshu.com/collection/bfcf49bf5d27    GitHub:https://github.com/LiFuPeng       蜗牛     */. All rights reserved.
//

#import "pictureViewCell.h"
#import "UIImageView+WebCache.h"

@implementation pictureViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建子视图
        [self initViews] ;
    }
    return self;
}


/**
 *  创建子视图
 */
- (void)initViews
{
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
    _scrollView.maximumZoomScale = 3.0 ;
    _scrollView.minimumZoomScale = 0.5 ;
    _scrollView.delegate = self ;
    [self.contentView addSubview:_scrollView] ;
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)] ;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // 开启点击事件
    self.imageView.userInteractionEnabled = YES ;
    [_scrollView addSubview:self.imageView] ;
    // 给图片数据添加一个点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTapAction)] ;
    [self.imageView addGestureRecognizer:tap] ;
}


/**
 *  图片的点击事件
 */
- (void)imageViewTapAction
{
    // 还原原始比例
    [UIView animateWithDuration:0.2 animations:^{
        self.scrollView.zoomScale = 1.0 ;
    }] ;
}

/**
 *  复用方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews] ;
    
    _scrollView.zoomScale = 1 ;
    NSURL *url = [NSURL URLWithString:self.imageUrlString] ;
    [self.imageView sd_setImageWithURL:url] ;
    //获取网络图片的尺寸大小
    CGSize size = [self getImageSizeWithURL:url];
    float scale = size.height/size.width;
    float fHeight = _scrollView.frame.size.width*scale;
    self.imageView.frame = CGRectMake(0,(_scrollView.frame.size.height-fHeight)/2, _scrollView.frame.size.width , fHeight);
    _scrollView.contentSize = self.imageView.frame.size;
    
    
}



//-(void)setImageUrlString:(NSString *)imageUrlString{
//    
//    _imageUrlString=imageUrlString;
//    
//    _scrollView.zoomScale = 1 ;
//    NSURL *url = [NSURL URLWithString:self.imageUrlString] ;
//    [self.imageView sd_setImageWithURL:url] ;
//    //获取网络图片的尺寸大小
//    CGSize size = [self getImageSizeWithURL:url];
//    float scale = size.height/size.width;
//    float fHeight = _scrollView.frame.size.width*scale;
//    self.imageView.frame = CGRectMake(0,(_scrollView.frame.size.height-fHeight)/2, _scrollView.frame.size.width , fHeight);
//    _scrollView.contentSize = self.imageView.frame.size;
//
//
//}
//UIImageView根据UIScrollView的中心点进行缩放
-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    self.imageView.center = CGPointMake(xcenter, ycenter);
    
}

#pragma mark - UIScrollView的代理方法
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return self.imageView ;
}
// 根据图片url获取图片尺寸
- (CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url返回不正确的CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}
//  获取PNG图片的大小
- (CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        //        if (word == 0xdb) {
        [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
        if (word == 0xdb) {// 两个DQT字段
            short w1 = 0, w2 = 0;
            [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
            [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
            short w = (w1 << 8) + w2;
            short h1 = 0, h2 = 0;
            [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
            [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
            short h = (h1 << 8) + h2;
            return CGSizeMake(w, h);
        } else {// 一个DQT字段
            short w1 = 0, w2 = 0;
            [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
            [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
            short w = (w1 << 8) + w2;
            short h1 = 0, h2 = 0;
            [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
            [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
            short h = (h1 << 8) + h2;
            return CGSizeMake(w, h);
        }
        //        } else {
        //            return CGSizeZero;
        //        }
    }
}



@end
