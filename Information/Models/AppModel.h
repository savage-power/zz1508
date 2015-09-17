//
//  AppModel.h
//  Information
//
//  Created by qianfeng on 15/9/11.
//  Copyright (c) 2015年 刘强. All rights reserved.
//

#import "LQModel.h"
#import <UIKit/UIKit.h>
@interface AppModel : LQModel

@property (nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *source;

@property(nonatomic,copy)NSString *clickNum;

@property(nonatomic,copy)NSString *brief;

@property(nonatomic,copy)NSString *host;

@property(nonatomic,copy)NSString *dir;

@property(nonatomic,copy)NSString *filepath;

@property(nonatomic,copy)NSString *filename;

@property(nonatomic,copy)NSString *author;

@property(nonatomic,copy)NSString *contentUrl;

@property(nonatomic,strong)UIButton *button;



@end
