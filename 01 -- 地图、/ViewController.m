//
//  ViewController.m
//  01 -- 地图、
//
//  Created by 千锋 on 16/3/18.
//  Copyright (c) 2016年 abc. All rights reserved.
//

#import "ViewController.h"
#import "CLLocation+Sino.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>{

    MKMapView * myMapView;
    CLLocationManager * myLocationManager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 地理信息编码/反编码对象、
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
#if 0
    
    // 地理信息正向编码(地名转换成经纬度)
    [geoCoder geocodeAddressString:@"青羊宫" completionHandler:^(NSArray *placemarks, NSError *error) {
        
        // 对编码结果进行迭代
        for (CLPlacemark *pMark in placemarks) {
            
            // 将地址字典转换成二进制数据
            NSData *data = [NSJSONSerialization dataWithJSONObject:pMark.addressDictionary options:NSJSONWritingPrettyPrinted error:nil];
            // 将二进制数据转换成字符串
            NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",str);
            
        }
        
    }];
#endif
    
#if 1
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:30.662056 longitude:104.041462];
    // 反编码地理信息(将经纬度转换为地名)
    [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
       
        CLPlacemark * pMark = [placemarks firstObject];
        
        NSLog(@"%@",pMark);
        
        MKPlacemark * mkmark = [[MKPlacemark alloc] initWithPlacemark:pMark];
        // 开启地图应用的加载项
        NSDictionary * options = @{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsShowsTrafficKey:@(YES)};
        
        // 创建一个地图应用型
        MKMapItem * mapItem = [[MKMapItem alloc] initWithPlacemark:mkmark];
        
        // 开启一个地图应用、
        [mapItem openInMapsWithLaunchOptions:options];
    }];
#endif
    
    // 创建定位管理器对象、
    myLocationManager = [[CLLocationManager alloc] init];
    
    // 设置定位温度
    myLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 设置距离过滤器
    myLocationManager.distanceFilter = 5;
    
    // 绑定委托
    myLocationManager.delegate = self;
    
    // 授权一直开启定位服务、
    [myLocationManager requestWhenInUseAuthorization];
    
    // 开启定位服务(开始更新位置信息)
    [myLocationManager startUpdatingLocation];
    
    // 创建地图对象
    myMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    // 绑定委托
    myMapView.delegate = self;
    
    // 显示用户位置
    myMapView.showsUserLocation = YES;
    
    // 设置经纬度坐标、
//    CLLocationCoordinate2D c2d = CLLocationCoordinate2DMake(30.662056, 104.041462);
    
    // 设置坐标跨度、
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    // 设置地图的显示区域、
    [myMapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(3.066256, 104.041462), span) animated:YES];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
