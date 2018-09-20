//
//  deleteBrowseHistoryCell.h
//  portal
//
//  Created by Store on 2017/9/20.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BrowseHistoryCell.h"

@interface deleteBrowseHistoryCell : BrowseHistoryCell
@property (nonatomic, copy) void (^SelectIndex)(NSNumber *favorId);
@end
