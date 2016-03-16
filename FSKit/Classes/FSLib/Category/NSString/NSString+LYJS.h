//
//  NSString+LYJS.h
//  shuaidanbao
//
//  Created by 吴浪 on 15/11/17.
//  Copyright © 2015年 sdb. All rights reserved.
//

/** 用于导出常用javascript字符串，做一些简单的页面处理 */



#import <Foundation/Foundation.h>
#define PROTOCOL     @"PROTOCOL"
#define HOST          @"HOST"
#define PARAMS          @"PARAMS"
#define URI               @"URI"


@interface NSString (LYJS)

/** 禁止UIWebView页面的静态链接 YES=取消超链接 NO=恢复超链接 */
+ (NSString *)jsForbidLink:(BOOL)flag;
/** 禁止UIWebView页面复制粘贴 */
+ (NSString *)jsForbidCopy;
/** 禁止UIWebView页面长按弹出菜单与圆圈放大镜 */
+ (NSString *)jsForbidMenu;
/** UIWebView页面滚动到顶部 */
+ (NSString *)jsScrollToTop;

/**
 *  @param NSString *URL 需要解析的URL，格式如：http://host.name/testpage/?keyA=valueA&keyB=valueB
 *  @return NSDictionary *params 从URL中解析出的参数表
 *    PROTOCOL 如 http
 *    HOST     如 host.name
 *    PARAMS   如 {keyA:valueA, keyB:valueB}
 *    URI      如 /testpage
 */
- (NSDictionary *)paramsFromURL;
@end
