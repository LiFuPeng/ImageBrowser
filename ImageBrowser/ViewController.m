//
//  ViewController.m
//  ImageBrowser
//
//  Created by 蜗牛 on 16/9/7.
//  Copyright © 2016年 关于蜗牛：一枚九零后码农  蜗牛-----QQ:3197857495-----李富棚  个人微信：woniu1308822159  微信公众号：woniuxueios  简书：蜗牛学IOS  地址：http://www.jianshu.com/users/a664a9fcb096/latest_articles  简书专题：蜗牛学IOS  地址：http://www.jianshu.com/collection/bfcf49bf5d27    GitHub:https://github.com/LiFuPeng       蜗牛     */. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "pictureViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    //集合视图
    UICollectionView *CollectionView;
    //图片数组
    NSArray *imageArray;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    imageArray=@[@"http://www.pp3.cn/uploads/201608/20160801009.jpg",
                 @"http://img0.imgtn.bdimg.com/it/u=2333194626,2820495568&fm=11&gp=0.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJlbKyaiIWb94ABPLYcQNMykAALIQwCA8u8AE8t5061.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/00/0A/ChMkJlecZd-IBWxcAAYtXMKnTOEAAT_3wDlLEoABi10024.jpg",@"http://pic2016.5442.com:82/2016/0811/6/1.jpg%21960.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0E/0F/ChMkJlYnQP-IJMgVAAmQZYGpP-wAAD7ZwD1frYACZB9878.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJ1d03hmIaNlPAAJJTlLBSN8AATGhQOU1qoAAklm694.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0B/0F/ChMkJlaDfraII4JOABWgccZ6H1sAAGu9AHyI0kAFaCJ842.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyqeIWBwBADlexJVOKHMAALIewOsURQAOV7c671.jpg",@"http://www.pp3.cn/uploads/201608/20160801009.jpg",
                 @"http://img0.imgtn.bdimg.com/it/u=2333194626,2820495568&fm=11&gp=0.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJlbKyaiIWb94ABPLYcQNMykAALIQwCA8u8AE8t5061.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/00/0A/ChMkJlecZd-IBWxcAAYtXMKnTOEAAT_3wDlLEoABi10024.jpg",@"http://pic2016.5442.com:82/2016/0811/6/1.jpg%21960.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0E/0F/ChMkJlYnQP-IJMgVAAmQZYGpP-wAAD7ZwD1frYACZB9878.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJ1d03hmIaNlPAAJJTlLBSN8AATGhQOU1qoAAklm694.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0B/0F/ChMkJlaDfraII4JOABWgccZ6H1sAAGu9AHyI0kAFaCJ842.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyqeIWBwBADlexJVOKHMAALIewOsURQAOV7c671.jpg",@"http://www.pp3.cn/uploads/201608/20160801009.jpg",
                 @"http://img0.imgtn.bdimg.com/it/u=2333194626,2820495568&fm=11&gp=0.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJlbKyaiIWb94ABPLYcQNMykAALIQwCA8u8AE8t5061.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/00/0A/ChMkJlecZd-IBWxcAAYtXMKnTOEAAT_3wDlLEoABi10024.jpg",@"http://pic2016.5442.com:82/2016/0811/6/1.jpg%21960.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0E/0F/ChMkJlYnQP-IJMgVAAmQZYGpP-wAAD7ZwD1frYACZB9878.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJ1d03hmIaNlPAAJJTlLBSN8AATGhQOU1qoAAklm694.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0B/0F/ChMkJlaDfraII4JOABWgccZ6H1sAAGu9AHyI0kAFaCJ842.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyqeIWBwBADlexJVOKHMAALIewOsURQAOV7c671.jpg",@"http://www.pp3.cn/uploads/201608/20160801009.jpg",
                 @"http://img0.imgtn.bdimg.com/it/u=2333194626,2820495568&fm=11&gp=0.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJlbKyaiIWb94ABPLYcQNMykAALIQwCA8u8AE8t5061.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/00/0A/ChMkJlecZd-IBWxcAAYtXMKnTOEAAT_3wDlLEoABi10024.jpg",@"http://pic2016.5442.com:82/2016/0811/6/1.jpg%21960.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0E/0F/ChMkJlYnQP-IJMgVAAmQZYGpP-wAAD7ZwD1frYACZB9878.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/05/ChMkJ1d03hmIaNlPAAJJTlLBSN8AATGhQOU1qoAAklm694.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/0B/0F/ChMkJlaDfraII4JOABWgccZ6H1sAAGu9AHyI0kAFaCJ842.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/06/ChMkJlbKyqeIWBwBADlexJVOKHMAALIewOsURQAOV7c671.jpg"];
    
    [self createCollectionView];
    
    
    
}

-(void)createCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-40) collectionViewLayout:layout];
    //[CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    CollectionView.backgroundColor = [UIColor whiteColor];
    CollectionView.delegate = self;
    CollectionView.dataSource = self;
    [self.view addSubview:CollectionView];
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [CollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    static NSString *identify=@"CollectionViewCell";
    CollectionViewCell *cell=(CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    cell.url=imageArray[indexPath.row];
    
    return cell;
}

//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((kScreenWidth-50)/3, (kScreenWidth-40)/5);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    pictureViewController *pvc=[[pictureViewController alloc]init];
    pvc.selectInteger=indexPath.row;
    pvc.imageArray=imageArray;
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:pvc];
    [self presentViewController:navigation animated:YES completion:nil];
    
//        selectIndex = indexPath.row;
//        [self createWindowForBigPicture];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
