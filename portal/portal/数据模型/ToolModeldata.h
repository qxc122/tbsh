//
//  ToolModeldata.h
//  TourismT
//
//  Created by Store on 16/12/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>



///我的消息
@interface appIdAndSecret : NSObject
@property (nonatomic,strong) NSString *appId;
@property (nonatomic,strong) NSString *appSecret;
@end

@interface accessToken : NSObject
@property (nonatomic,strong) NSString *sessionSecret;
@property (nonatomic,strong) NSString *sessionKey;
@property (nonatomic,strong) NSDate *expireTime;
@property (nonatomic,strong) NSString *accessToken;
@end

@interface UserInfo : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *authenTicket;
@property (nonatomic,strong) NSURL *headUrl;
@property (nonatomic,strong) NSString *authenUserId;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *vipLevel;
@property (nonatomic,strong) NSString *loginTime;
@property (nonatomic,strong) NSString *bindFlag;
@property (nonatomic,strong) NSString *hasUnreadNews;
@end

@interface GlobalParameter : NSObject
@property (nonatomic,strong) NSURL *backgroundImg;
@property (nonatomic,strong) NSString *isPassForIOS;
@property (nonatomic,strong) NSString *isPassForIOSQQ;
@property (nonatomic,strong) NSURL *userAgreementUrl;
@property (nonatomic,strong) NSURL *privacyAgreementUrl;
@property (nonatomic,strong) NSURL *serviceAgreementUrl;
@end


@interface HomeData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_merchList;
@end

@interface HomeDataOne : NSObject
@property (nonatomic,strong) NSString *finFlag;
@property (nonatomic,strong) NSURL *merchLink;
@property (nonatomic,strong) NSString *merchName;
@property (nonatomic,strong) NSURL *merchIcon;
@property (nonatomic,strong) NSString *merchId;
@property (nonatomic,assign) BOOL needLogin;
@end

@interface leftData : NSObject
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;
@end

@interface MyNewsData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_newsList;
@property (nonatomic,strong) NSString *hasMore;
@end

@interface MyNewsData_One : NSObject
@property (nonatomic,strong) NSString *newsDate;
@property (nonatomic,strong) NSURL *newsImg;
@property (nonatomic,strong) NSString *newsTitle;
@property (nonatomic,strong) NSURL *newsLink;
@property (nonatomic,strong) NSNumber *newsId;
@property (nonatomic,strong) NSString *newsType;
@end

@interface MyCollecData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_List;
@property (nonatomic,strong) NSString *hasMore;
@end

@interface MyCollecData_One : NSObject
@property (nonatomic,strong) NSURL *logo;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSNumber *favorId;
@property (nonatomic,strong) NSString *date;
@end


@interface FinanceVcData : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_insuranceProductList;
@property (nonatomic,strong) NSMutableArray *Arry_tourProductList;
@property (nonatomic,strong) NSMutableArray *Arry_tpurseProductList;
@property (nonatomic,strong) NSURL *fundProductLink;
@property (nonatomic,strong) NSURL *fundProductPicture;
@property (nonatomic,strong) NSURL *vcProductLink;
@property (nonatomic,strong) NSURL *vcProductPicture;
@end

@interface FinanceVcData_One : NSObject
@property (nonatomic,strong) NSString *productPrice;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *productDesc;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,assign) BOOL needLogin;
@property (nonatomic,strong) NSURL *productLink;
@property (nonatomic,strong) NSURL *productPicture;
@end


@interface passengerInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_passengerInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface passengerInfos_one : NSObject
@property (nonatomic,strong) NSString *enName;
@property (nonatomic,strong) NSMutableArray *Arry_certInfos;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,assign) NSInteger passengerId;
@property (nonatomic,strong) NSString *selfFlag;
@property (nonatomic,strong) NSString *surname; 
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *nationalityCode;
@property (nonatomic,strong) NSString *nationalityName;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,strong) NSString *expireDate;
@end

@interface certInfos_one : NSObject
@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *nationality;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,assign) NSInteger certId;
@property (nonatomic,strong) NSString *expireDate;
@end

@interface contactInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_contactInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface contactInfos_one : NSObject
@property (nonatomic,strong) NSString *email;
@property (nonatomic,assign) NSInteger contactId;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *selfFlag;
@end

@interface addressInfos : NSObject
@property (nonatomic,strong) NSMutableArray *Arry_addressInfos;
@property (nonatomic,strong) NSString *hasMore;
@end
@interface addressInfos_one : NSObject
@property (nonatomic,strong) NSString *receiverMobile;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,assign) NSInteger addressId;
@property (nonatomic,strong) NSString *receiverName;
@property (nonatomic,strong) NSString *selfFlag;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *detailAddress;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *postCode;
@end

@interface CheckApp : NSObject
@property (nonatomic,strong) NSString *appName;
@property (nonatomic,strong) NSString *verName;
@property (nonatomic,strong) NSString *updateType;
@end

@interface setUp : NSObject
@property (nonatomic,assign) BOOL ReceiveNotification;
@property (nonatomic,assign) BOOL AutoUpdate;
@end

@interface payPre : NSObject
@property (nonatomic,strong) NSString *sysId;
@property (nonatomic,strong) NSString *sign;
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *v;
@property (nonatomic,strong) NSString *orderId;
@end

@interface payData : NSObject
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderName;
@property (nonatomic,strong) NSString *supportTcoin;
@property (nonatomic,strong) NSNumber *orderPrice;
@end

