//
//  AppDelegate.m
//  LocationInTime
//
//  Created by 黄龙辉 on 14/11/27.
//  Copyright (c) 2014年 海南久其云计算科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTableViewCtrl.h"

static NSString *recordKey = @"record";

@implementation AppDelegate{
    CLLocationManager *locationManager;
    MyTableViewCtrl *tableViewCtrl;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startMonitoringSignificantLocationChanges];
    
    tableViewCtrl = [[MyTableViewCtrl alloc] init];
    self.window.rootViewController = tableViewCtrl;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *recordArray = [[userDefault objectForKey:recordKey] mutableCopy];
    if (nil == recordArray) {
        recordArray = [[NSMutableArray alloc] init];
    }
    NSUInteger i = [recordArray count];
    NSString *str = [NSString stringWithFormat:@"%ld:lat:%g lng:%g", i, newLocation.coordinate.latitude, newLocation.coordinate.longitude];
    [recordArray insertObject:str atIndex:0];
    [userDefault setObject:recordArray forKey:recordKey];
    [userDefault synchronize];
    
    tableViewCtrl.dataSource = [recordArray copy];
    [tableViewCtrl.tableView reloadData];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
