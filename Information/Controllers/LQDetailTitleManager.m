//
//  LQDetailTitleManager.m
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "LQDetailTitleManager.h"

@implementation LQDetailTitleManager

+ (instancetype)sharedInstance {
    
    static LQDetailTitleManager *titleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        titleManager = [[LQDetailTitleManager alloc]init];
        
    });
    
    return titleManager;
}
-(WMPageController *)addDetailWithControllersArray:(NSArray *)viewControllers titles:(NSArray *)titles
    {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < viewControllers.count; i++) {
            Class vcClass = NSClassFromString(viewControllers[i]);
            [array addObject:vcClass];
        }
        WMPageController *pageVC = [[WMPageController alloc]initWithViewControllers:array andTheirTitles:titles];
        return pageVC;
    }



@end
