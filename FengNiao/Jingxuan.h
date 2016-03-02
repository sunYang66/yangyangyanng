//
//  Jingxuan.h
//  FengNiao
//
//  Created by qianfeng on 15-1-26.
//  Copyright (c) 2015年 yangran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jingxuan : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *pic_src;
@property(nonatomic,copy)NSString *pic_url;
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *comments_num;
@property(nonatomic,copy)NSString *more_comment_url;
@property(nonatomic,copy)NSString *web_url;
@property(nonatomic,copy)NSString *doc_id;
@property(nonatomic,copy)NSString *doc_url;
@property(nonatomic,copy)NSString *author;

@property(nonatomic)int comment_page_num;
@end

