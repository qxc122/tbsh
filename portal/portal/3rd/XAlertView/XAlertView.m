//
//  XAlertView.m
//  xinlvtong
//
//  Created by Euan Chan on 5/23/14.
//  Copyright (c) 2014 cncn. All rights reserved.
//

#import "XAlertView.h"

@interface XAlertView () <UIAlertViewDelegate>

@property (copy, nonatomic) void (^clickBlock)(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex);

@end

@implementation XAlertView

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
       clickedBlock:(void (^)(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex))clickedBlock
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    if (self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil]) {
        _clickBlock = clickedBlock;
        va_list _arguments;
        va_start(_arguments, otherButtonTitles);
        for (NSString *otherTitle = otherButtonTitles; otherTitle != nil; otherTitle = (__bridge NSString *)va_arg(_arguments, void *)) {
            [self addButtonWithTitle:otherTitle];
        }
        va_end(_arguments);
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _clickBlock(self, buttonIndex == self.cancelButtonIndex, buttonIndex);
}
//- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
//    if (!self.isDisappear) {
//        NSLog(@"不消失");
//    }else{
//        [super dismissWithClickedButtonIndex:buttonIndex animated:animated]; // 消失
//    }
//}
@end
