//
//  travellerCell.m
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "travellerCell.h"
#import "NSString+Add.h"
#define kMaxLength   20

@interface travellerCell ()<UITextFieldDelegate>
@property (nonatomic,weak) UIImageView *lineimage;
@property (nonatomic,weak) UIImageView *selecetDown;
@property (nonatomic,weak) UIButton *selecetDownBtn;
@property (nonatomic,weak) UIButton *sexF;
@property (nonatomic,weak) UIButton *sexM;
@property (nonatomic,weak) UIImageView *rightImg;

@end

@implementation travellerCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    travellerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[travellerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        UITextField *contentTF = [UITextField new];
        contentTF.delegate = self;
        [self.contentView addSubview:contentTF];
        [contentTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        self.contentTF = contentTF;
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledEditChanged:)name:UITextFieldTextDidChangeNotification object:contentTF];

        
        UIImageView *lineimage = [UIImageView new];
        [self.contentView addSubview:lineimage];
        self.lineimage = lineimage;
        
        UIImageView *selecetDown = [UIImageView new];
        [self.contentView addSubview:selecetDown];
        self.selecetDown = selecetDown;
        
        UIButton *selecetDownBtn = [UIButton new];
        [self.contentView addSubview:selecetDownBtn];
        self.selecetDownBtn = selecetDownBtn;
        
        UIButton *sexM = [UIButton new];
        [self.contentView addSubview:sexM];
        self.sexM = sexM;
        
        UIButton *sexF = [UIButton new];
        [self.contentView addSubview:sexF];
        self.sexF = sexF;
        
        UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.rightImg = rightImg;
        [rightImg setImage:[UIImage imageNamed:CLICK_RIGHT]];
        [self.contentView addSubview:rightImg];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
//            make.width.equalTo(@(70));
            make.height.equalTo(@(15));
            make.left.equalTo(self.contentView).offset(15);
        }];
        [selecetDown mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@(7.4));
            make.height.equalTo(@(4.2));
            make.left.equalTo(title.mas_right).offset(5.6);
        }];
        [selecetDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title);
            make.height.equalTo(@(40));
            make.left.equalTo(title);
            make.right.equalTo(selecetDown);
        }];
        
        [contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(15));
            make.left.equalTo(title).offset(90);
            make.right.equalTo(lineimage);
        }];
        
        [sexM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title);
            make.width.equalTo(@(44));
            make.height.equalTo(@(44));
            make.left.equalTo(title).offset(90);
        }];
        [sexF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(title);
            make.width.equalTo(sexM);
            make.height.equalTo(sexM);
            make.left.equalTo(sexM.mas_right).offset(30);
        }];
        [lineimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(1));
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(-15);
            make.height.equalTo(@16);
            make.width.equalTo(@(10));
        }];
        [sexM setBackgroundImage:[UIImage imageNamed:SEX_MAN_SELECTION] forState:UIControlStateSelected];
        [sexF setBackgroundImage:[UIImage imageNamed:SEX_WOMAN_SELECTION] forState:UIControlStateSelected];
        sexM.titleLabel.font = PingFangSC_Regular(15);
        [sexM setTitleColor:ColorWithHex(0x494949 , 1.0) forState:UIControlStateNormal];
        [sexM setTitleColor:ColorWithHex(0xFFFFFF , 1.0) forState:UIControlStateSelected];
        [sexM setTitle:NSLocalizedString(@"male", @"male")forState:UIControlStateNormal];
        
        sexF.titleLabel.font = PingFangSC_Regular(15);
        [sexF setTitleColor:ColorWithHex(0x494949, 1.0) forState:UIControlStateNormal];
        [sexF setTitleColor:ColorWithHex(0xFFFFFF , 1.0) forState:UIControlStateSelected];
        [sexF setTitle:NSLocalizedString(@"female", @"female") forState:UIControlStateNormal];
        
        title.font = PingFangSC_Regular(15);
        title.textColor = ColorWithHex(0x494949, 1.0);
        
        [contentTF setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        contentTF.font = PingFangSC_Regular(15);
        contentTF.textColor = ColorWithHex(0x494949, 1.0);
        
        lineimage.backgroundColor = VIEW_BACKGROUND_COLOR;
        selecetDown.image = [UIImage imageNamed:ID_CARD_SELECTION];
        [selecetDownBtn addTarget:self action:@selector(selecetDownBtnFUNc) forControlEvents:UIControlEventTouchUpInside];
        self.selecetDown.hidden = YES;
        self.selecetDownBtn.hidden = YES;
        sexF.layer.borderWidth = 12.5;
        sexF.layer.borderColor = ColorWithHex(0xFFFFFF, 1.0).CGColor;
        sexM.layer.borderWidth = 12.5;
        sexM.layer.borderColor = ColorWithHex(0xFFFFFF, 1.0).CGColor;
        
        [sexF addTarget:self action:@selector(selecetSex:) forControlEvents:UIControlEventTouchUpInside];
        [sexM addTarget:self action:@selector(selecetSex:) forControlEvents:UIControlEventTouchUpInside];
        sexF.accessibilityIdentifier = SEX_WOMAN;
        sexM.accessibilityIdentifier = SEX_MAN;
    }
    return self;
}
- (void)selecetSex:(UIButton *)btn{
    if (!btn.selected) {
        if ([self.idNO IsIdCardNumber]) {
            [MBProgressHUD showPrompt:@"根据您的证件号，您的性别不可更改！"];
        }else{
            btn.selected = !btn.selected;
            if ([btn isEqual:self.sexM]) {
                self.sexF.selected = !btn.selected;
            } else if ([btn isEqual:self.sexF]) {
                self.sexM.selected  = !btn.selected;
            }
            if (self.Select_Sex) {
                self.Select_Sex(btn.accessibilityIdentifier);
            }
        }
    }
}
- (void)setIdentifer:(NSString *)identifer{
    _identifer = identifer;
    if ([identifer isEqualToString:KEY_CERNO]) {
        self.selecetDown.hidden = NO;
        self.selecetDownBtn.hidden = NO;
    }else{
        self.selecetDown.hidden = YES;
        self.selecetDownBtn.hidden = YES;
    }
    if ([identifer isEqualToString:KEY_SEX]) {
        self.sexF.hidden = NO;
        self.sexM.hidden = NO;
    }else{
        self.sexF.hidden = YES;
        self.sexM.hidden = YES;
    }
    self.contentTF.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    if ([identifer isEqualToString:KEY_NAME]) {
        self.contentTF.keyboardType = UIKeyboardTypeDefault;
    } else if ([identifer isEqualToString:KEY_MOBILE]) {
        self.contentTF.keyboardType = UIKeyboardTypePhonePad;
    } else if ([identifer isEqualToString:KEY_EMAIL]) {
       self.contentTF.keyboardType = UIKeyboardTypeEmailAddress;
    } else if ([identifer isEqualToString:KEY_RECEIVERNAME]) {
         self.contentTF.keyboardType = UIKeyboardTypeDefault;
    } else if ([identifer isEqualToString:KEY_DETAILADDRESS]) {
         self.contentTF.keyboardType = UIKeyboardTypeDefault;
    } else if ([identifer isEqualToString:KEY_POSTCODE]) {
        self.contentTF.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    } else if ([identifer isEqualToString:KEY_ENNAME]) {
         self.contentTF.keyboardType = UIKeyboardTypeNamePhonePad;
        self.contentTF.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;//所有字母都大写
    } else if ([identifer isEqualToString:KEY_SUNAME]) {
        self.contentTF.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;//所有字母都大写
        self.contentTF.keyboardType = UIKeyboardTypeNamePhonePad;
    } else if ([identifer isEqualToString:KEY_CERNO]) {
        self.contentTF.keyboardType = UIKeyboardTypeDefault;
    } else if ([identifer isEqualToString:KEY_AREA]) {

    }
//    self.contentTF.keyboardType = UIKeyboardTypeASCIICapable;
//    self.contentTF.returnKeyType = UIReturnKeyDone;
    if ([identifer isEqualToString:KEY_BIRTHDAY] || [identifer isEqualToString:KEY_SEX]  || [identifer isEqualToString:KEY_NATIONALITY] || [identifer isEqualToString:KEY_EXPIREDATE] || [identifer isEqualToString:KEY_AREA]) {
        self.contentTF.userInteractionEnabled = NO;
        if (![identifer isEqualToString:KEY_SEX]) {
            self.rightImg.hidden = NO;
            self.contentTF.hidden = NO;
        }else{
            self.rightImg.hidden = YES;
            self.contentTF.hidden = YES;
        }
    }else{
        self.contentTF.userInteractionEnabled = YES;
        self.contentTF.hidden = NO;
        self.rightImg.hidden = YES;
    }
}
- (void)setSexMF:(NSString *)sexMF{
    _sexMF = sexMF;
    if ([sexMF isEqualToString:SEX_MAN]) {
        self.sexM.selected = YES;
    } else if ([sexMF isEqualToString:SEX_WOMAN]) {
        self.sexF.selected = YES;
    }
}
- (void)selecetDownBtnFUNc{
    if (self.Select_type) {
        if ([self.contentTF isFirstResponder]) {
            [self.contentTF resignFirstResponder];
        }
        self.Select_type();
    }
}

//-(void)textFiledEditChanged:(id)notification{
//    if ([self.identifer isEqualToString:KEY_RECEIVERNAME] || [self.identifer isEqualToString:KEY_NAME]) {
//        UITextRange *selectedRange = self.contentTF.markedTextRange;
//        UITextPosition *position = [self.contentTF positionFromPosition:selectedRange.start offset:0];
//        
//        if (!position) { //// 没有高亮选择的字
//            //过滤非汉字字符
//            self.contentTF.text = [self filterCharactor:self.contentTF.text withRegex:@"[^\u4e00-\u9fa5]"];
//        }else { //有高亮文字
//        }
//    }
//}

-(NSString *)filterCharactor:(NSString* )string withRegex:(NSString* )regexStr{
    NSString *searchText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
    return result;
}


#pragma  -mark<输入框改变了>
-(void)textFieldDidChange :(UITextField *)textField{
    NSString *toBeString = textField.text;
    NSString *lastString;
    if(toBeString.length>0)
        lastString=[toBeString substringFromIndex:toBeString.length-1];
    
    if (![self isInputRuleAndNumber:toBeString]&&[self hasEmoji:lastString]) {
        textField.text = [self disable_emoji:toBeString];
    }
    
    if ([self.identifer isEqualToString:KEY_ENNAME]) {
        NSString *tmp = [textField.text uppercaseString];
        textField.text = tmp;
    } else if ([self.identifer isEqualToString:KEY_SUNAME]) {
        NSString *tmp = [textField.text uppercaseString];
        textField.text = tmp;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.identifer isEqualToString:KEY_RECEIVERNAME] || [self.identifer isEqualToString:KEY_NAME]) {
        self.contentTF.text = [self filterCharactor:self.contentTF.text withRegex:@"[^\u4e00-\u9fa5]"];
    }
    if (self.Fill_in_the_text) {
        self.Fill_in_the_text(self.identifer, textField.text);
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.Begin_Fill_in_the_text) {
        self.Begin_Fill_in_the_text(textField);
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"shuru=%@ ragng=%lu ragng=%lu",string,(unsigned long)range.location,(unsigned long)range.length);
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([self isInputRuleAndNumber:string]) {
        if ([self.identifer isEqualToString:KEY_NAME]) {
            //                if (![string isChinese]) {
            //                    return NO;
            //                }
        } else if ([self.identifer isEqualToString:KEY_MOBILE]) {
            if (![string deptNumInputShouldNumber] || textField.text.length + string.length>11) {
                return NO;
            }
        } else if ([self.identifer isEqualToString:KEY_EMAIL]) {
            if ([string includeChinese]) {
                return NO;
            }
        } else if ([self.identifer isEqualToString:KEY_RECEIVERNAME]) {
            //                if (![string isChinese]) {
            //                    return NO;
            //                }
        } else if ([self.identifer isEqualToString:KEY_DETAILADDRESS]) {
            
        } else if ([self.identifer isEqualToString:KEY_POSTCODE]) {
            if (![string deptNumInputShouldNumber]  || textField.text.length + string.length>6) {
                return NO;
            }
        } else if ([self.identifer isEqualToString:KEY_ENNAME]) {
            if ([string deptPassInputShouldAlpha]) {
                return NO;
            }
            string = [string uppercaseString];
            textField.text = [textField.text stringByAppendingString:string];
            if (self.Fill_in_the_text) {
                self.Fill_in_the_text(self.identifer, textField.text);
            }
            return NO;
        } else if ([self.identifer isEqualToString:KEY_SUNAME]) {
            if ([string deptPassInputShouldAlpha]) {
                return NO;
            }
            string = [string uppercaseString];
            textField.text = [textField.text stringByAppendingString:string];
            if (self.Fill_in_the_text) {
                self.Fill_in_the_text(self.identifer, textField.text);
            }
            return NO;
        } else if ([self.identifer isEqualToString:KEY_CERNO]) {
            if (([string deptPassInputShouldAlpha] && ![string deptNumInputShouldNumber]) || textField.text.length + string.length>18) {
                return NO;
            }
            string = [string uppercaseString];
            textField.text = [textField.text stringByAppendingString:string];
            if (self.Fill_in_the_text) {
                self.Fill_in_the_text(self.identifer, textField.text);
            }
            return NO;
        }
        return YES;
    }
    return NO;
}

/**
 * 字母、数字、中文
 */
- (BOOL)isInputRuleAndNumber:(NSString *)str
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    unsigned long len=str.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[str characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='@') || (a == '@'))
             ||((a=='.') || (a == '.'))
             ||((a >= 0x4e00 && a <= 0x9fa5))
             ||([other rangeOfString:str].location != NSNotFound)
             ))
            return NO;
    }
    return YES;
}

/**
 *  过滤字符串中的emoji
 */
- (BOOL)hasEmoji:(NSString*)str{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}
@end
