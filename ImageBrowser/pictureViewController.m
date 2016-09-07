//
//  pictureViewController.m
//  ImageBrowser
//
//  Created by 蜗牛 on 16/9/7.
//  Copyright © 2016年 关于蜗牛：一枚九零后码农  蜗牛-----QQ:3197857495-----李富棚  个人微信：woniu1308822159  微信公众号：woniuxueios  简书：蜗牛学IOS  地址：http://www.jianshu.com/users/a664a9fcb096/latest_articles  简书专题：蜗牛学IOS  地址：http://www.jianshu.com/collection/bfcf49bf5d27    GitHub:https://github.com/LiFuPeng       蜗牛     */. All rights reserved.
//

#import "pictureViewController.h"
#import "pictureViewCell.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface pictureViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong)UICollectionView *CollectionView;
@property (nonatomic,strong) UILabel * label;
@end

@implementation pictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInitialValue];
    
    [self createCollectionView];
}

-(void)addInitialValue{
    self.title=@"图片查看";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 35, 35);
    [leftButton setImage:[UIImage imageNamed:@"Back.png"] forState:0];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, -10, 5, 10)];
    [leftButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [leftButton addTarget:self action:@selector(goBackItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)goBackItem:(UIBarButtonItem *)itme{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



-(void)createCollectionView{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init] ;
    flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) ;
    flowLayout.minimumInteritemSpacing = 0 ;
    flowLayout.minimumLineSpacing = 0;
    
    // 设置方法
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    self.CollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout] ;
    self.CollectionView.backgroundColor = [UIColor blackColor] ;
    self.CollectionView.delegate = self ;
    self.CollectionView.dataSource = self ;
    self.CollectionView.pagingEnabled = YES ;
    self.CollectionView.contentOffset = CGPointMake(([UIScreen mainScreen].bounds.size.width)*_selectInteger, [UIScreen mainScreen].bounds.size.height);
    self.CollectionView.showsHorizontalScrollIndicator = NO ;
    //[self.CollectionView registerClass:[ImageEnlargeCell class] forCellWithReuseIdentifier:@"cellID"] ;
    [self.view addSubview:self.CollectionView] ;
    
    
    // 创建下面页数显示的文本
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width-200, 20)] ;
    self.label.textAlignment = NSTextAlignmentCenter ;
    self.label.textColor = [UIColor whiteColor] ;
    self.label.text = [NSString stringWithFormat:@"%ld/%lu",_selectInteger+1,(unsigned long)self.imageArray.count] ;
    [self.view addSubview:self.label] ;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_CollectionView registerClass:[pictureViewCell class] forCellWithReuseIdentifier:@"pictureViewCell"];
    static NSString *identify=@"pictureViewCell";
    pictureViewCell *cell=(pictureViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.imageUrlString = self.imageArray[indexPath.row] ;
    // 刷新视图
    [cell setNeedsLayout] ;
    
    return cell;
}

//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(kScreenWidth, kScreenWidth);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  

    
    int pageIndex = (int)self.CollectionView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;
    self.label.text = [NSString stringWithFormat:@"%d/%lu",pageIndex+1,(unsigned long)self.imageArray.count] ;
    NSLog(@"====%f====%f====%d",self.CollectionView.contentOffset.x,[UIScreen mainScreen].bounds.size.width ,pageIndex);
    
}














@end
