//
//  XAlertView.h
//  xinlvtong
//
//  Created by Euan Chan on 5/23/14.
//  Copyright (c) 2014 cncn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XAlertView : UIAlertView
//@property (nonatomic,assign) BOOL isDisappear;
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       clickedBlock:(void (^)(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex))clickedBlock
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
