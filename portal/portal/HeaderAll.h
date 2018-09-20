//
//  HeaderAll.h
//  portal
//
//  Created by Store on 2017/8/30.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#ifndef HeaderAll_h
#define HeaderAll_h

#import "MBProgressHUD+MJ.h"
#import "MACRO_COLOR.h"
#import "MACRO_UIFONT.h"
#import "Masonry.h"
#import "MACRO_PIC.h"
#import "ToolModeldata.h"
#import "MACRO_PORTAL.h"
#import "UIImageView+WebCache.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "MACRO_UI.h"
#import "MACRO_ENUM.h"
#import "ToolRequest+common.h"
#import "MACRO_NOTICE.h"
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define TOURPAGESIZE 10
#define FIRSTPAGE    1


#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define PROPORTION_HEIGHT  SCREENHEIGHT/667.0
#define PROPORTION_WIDTH   SCREENWIDTH/375.0


#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* HeaderAll_h */
