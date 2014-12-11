//
//  MyTableViewCtrl.m
//  LocationInTime
//
//  Created by 黄龙辉 on 14/11/28.
//  Copyright (c) 2014年 海南久其云计算科技有限公司. All rights reserved.
//

#import "MyTableViewCtrl.h"

@implementation MyTableViewCtrl

- (id)init{
    
    self = [super init];
    if (self) {
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = CGRectMake(60, 440, 200, 40);
        [clearBtn setTitle:@"清空记录" forState:UIControlStateNormal];
        clearBtn.backgroundColor = [UIColor colorWithRed:0.210 green:0.697 blue:1.000 alpha:1.000];
        [clearBtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:clearBtn];
        self.view.clipsToBounds = NO;
        
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}


- (void)clear{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@"record"];
    [userDefault synchronize];
    self.tableView.dataSource = nil;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.tableView.frame = CGRectMake(0, 30, 320, 538);
    return self.dataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *str = self.dataSource[indexPath.row];
    
    cell.textLabel.text = str;
    
    return cell;
}

@end
