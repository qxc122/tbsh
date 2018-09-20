//
//  MACRO_URL.h
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#ifndef MACRO_URL_h
#define MACRO_URL_h


#ifdef DEBUG
#define  URLBASIC  @"http://172.18.126.58:8011/tpurse"
#else
#define  URLBASIC  @"https://tpurse.tempus.cn/tpurse"
#endif

#ifdef DEBUG
#define URLAddress  @"URLAddress"
#define productURLAddress  @"https://tpurse.tempus.cn/tpurse"

//#define tesetURLAddress  @"https://tpurse.tempus.cn/tpurse"
#define tesetURLAddress @"http://172.18.126.58:8011/tpurse"
#endif




#define     URLBASIC_tpurseappappIdApply       @"/app/appIdApply"
#define     URLBASIC_apptokenApply       @"/app/tokenApply"

#define     URLBASIC_appgetGlobalParams       @"/app/getGlobalParams"
#define     URLBASIC_portalqueryMerchList       @"/portal/queryMerchList"
#define     URLBASIC_systemsendVerifyCode       @"/system/sendVerifyCode"
#define     URLBASIC_userlogin       @"/user/login"
#define     URLBASIC_usermyInfo       @"/user/myInfo"
#define     URLBASIC_portalusermyNews       @"/portal/user/myNews"
#define     URLBASIC_appappUpdate       @"/app/appUpdate"


#define     URLBASIC_portalcommonInfoaddContactInfo       @"/portal/commonInfo/addContactInfo"
#define     URLBASIC_portalcommonInfodeleteContactInfo       @"/portal/commonInfo/deleteContactInfo"
#define     URLBASIC_portalcommonInfoeditContactInfo       @"/portal/commonInfo/editContactInfo"
#define     URLBASIC_portalcommonInfoqueryContactInfos       @"/portal/commonInfo/queryContactInfos"

#define     URLBASIC_portalcommonInfoaddAddressInfo       @"/portal/commonInfo/addAddressInfo"
#define     URLBASIC_portalcommonInfodeleteAddressInfo       @"/portal/commonInfo/deleteAddressInfo"
#define     URLBASIC_portalcommonInfoeditAddressInfo       @"/portal/commonInfo/editAddressInfo"
#define     URLBASIC_portalcommonInfoqueryAddressInfos       @"/portal/commonInfo/queryAddressInfos"

#define     URLBASIC_commonInfoaddPassengerInfo       @"/portal/commonInfo/addPassengerInfo"
#define     URLBASIC_commonInfodeletePassengerInfo       @"/portal/commonInfo/deletePassengerInfo"
#define     URLBASIC_commonInfoeditPassengerInfo       @"/portal/commonInfo/editPassengerInfo"
#define     URLBASIC_portalcommonInfoqueryPassengerInfos       @"/portal/commonInfo/queryPassengerInfos"


#define     URLBASIC_portalqueryOrderInfo       @"/portal/order/queryOrderInfo"

#define     URLBASIC_userthirdUserLogin       @"/portal/user/thirdUserLogin"

#define     URLBASIC_userthirdUserBind       @"/user/thirdUserBind"
#define     URLBASIC_appsubmitFeedback       @"/portal/app/submitFeedback"


#define     URLBASIC_userlogout       @"/user/logout"
#define     URLBASIC_portalqueryFinaProducts       @"/portal/queryFinaProducts"
#define     URLBASIC_usermodifyNickname       @"/user/modifyNickname"
#define     URLBASIC_userheadUpload       @"/user/headUpload" 
#define     URLBASIC_userrefreshLogin       @"/user/refreshLogin"
#define     URLBASIC_portaladdFavorite       @"/portal/addFavorite"
#define     URLBASIC_portalqueryFavorites       @"/portal/queryFavorites"
#define     URLBASIC_portalcancelFavorite       @"/portal/cancelFavorite"

#endif /* MACRO_URL_h */
