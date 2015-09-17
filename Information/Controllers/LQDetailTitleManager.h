//
//  LQDetailTitleManager.h
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMPageController.h"

@interface LQDetailTitleManager : NSObject

+ (instancetype)sharedInstance;

- (WMPageController *)addDetailWithControllersArray:(NSArray *)viewControllers titles:(NSArray *)titles;


@end
