//
//  ToolRequest+common.m
//  TourismT
//
//  Created by Store on 16/11/21.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest+common.h"
#import "MACRO_URL.h"
#import "OpenUDID.h"
#import "MACRO_PORTAL.h"
#import "ToolModeldata.h"
#import "PortalHelper.h"
#import "DateTools.h"
@implementation ToolRequest (common)

- (void)tpurseappappIdApplysuccess:(RequestSuccess)successBlock
                            failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    [self postJsonWithPath:URLBASIC_tpurseappappIdApply parameters:params success:successBlock failure:failureBlock];
}
- (void)appgetGlobalParamssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_appgetGlobalParams parameters:params success:successBlock failure:failureBlock];
}
- (void)portalqueryMerchListssuccess:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_portalqueryMerchList parameters:params success:successBlock failure:failureBlock];
}


- (void)apptokenApplysuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    appIdAndSecret *data = [PortalHelper sharedInstance].appid;
    if (data.appId) {
        [params setObject:data.appId forKey:@"appId"];
    }
    NSString *deviceId = [OpenUDID value];
    if (deviceId) {
        [params setObject:deviceId forKey:@"deviceId"];
    }
    NSString *timestamp = TIMESTAMP;
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    NSString *sign = @"000";
//    NSString *sign = [NSString stringWithFormat:@"%@%@%@",deviceId,data.appSecret,timestamp];
    if (sign) {
        [params setObject:sign forKey:@"sign"];
    }
    [self postJsonWithPath:URLBASIC_apptokenApply parameters:params success:successBlock failure:failureBlock];
}

- (void)systemsendVerifyCodeWithmobile:(NSString *)mobile
                                  type:(NSString *)type
                               success:(RequestSuccess)successBlock
                     failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (type) {
        [params setObject:type forKey:@"type"];
    }
    [self postJsonWithPath:URLBASIC_systemsendVerifyCode parameters:params success:successBlock failure:failureBlock];
}
- (void)userloginWithmobile:(NSString *)mobile
                                  verifyCode:(NSString *)verifyCode
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"]; 
    }
    [self postJsonWithPath:URLBASIC_userlogin parameters:params success:successBlock failure:failureBlock];
}

- (void)usermyInfosuccess:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_usermyInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_appappUpdatesuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *verCode = APP_BUILD;
    if (verCode) {
        verCode = [verCode stringByReplacingOccurrencesOfString:@"." withString:@""];
        NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        int remainSecond =[[verCode stringByTrimmingCharactersInSet:nonDigits] intValue];
        [params setObject:@(remainSecond) forKey:@"verCode"];
    }
    [self postJsonWithPath:URLBASIC_appappUpdate parameters:params success:successBlock failure:failureBlock];
}

- (void)portalusermyNewWithPageNum:(NSInteger)pageNum
                   ssuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalusermyNews parameters:params success:successBlock failure:failureBlock];
}

/*************************************************************************************************/
//联系人  增 删 该 查
//name	姓名
//mobile	手机号
//email	邮箱
//selfFlag	是否本人  @"0" 否   @"1"-是
- (void)portalcommonInfoaddContactInfoWithname:(NSString *)name
                           mobile:(NSString *)mobile
                           email:(NSString *)email
                           selfFlag:(NSString *)selfFlag
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (name) {
        [params setObject:name forKey:@"name"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (email) {
        [params setObject:email forKey:@"email"];
    }
    if (selfFlag  && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoaddContactInfo parameters:params success:successBlock failure:failureBlock];
}
//contactId	联系人编号
- (void)portalcommonInfodeleteContactInfoWithcontactId:(NSInteger)contactId
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (contactId>0) {
        [params setObject:@(contactId) forKey:@"contactId"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfodeleteContactInfo parameters:params success:successBlock failure:failureBlock];
}
//contactId	联系人编号
//name	姓名
//mobile	手机号
//email	邮箱
//selfFlag	是否本人
- (void)portalcommonInfoeditContactInfoWithcontactId:(NSInteger )contactId
                                                name:(NSString *)name
                                        mobile:(NSString *)mobile
                                         email:(NSString *)email
                                      selfFlag:(NSString *)selfFlag
                                      ssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (contactId>0) {
        [params setObject:@(contactId) forKey:@"contactId"];
    }
    if (name) {
        [params setObject:name forKey:@"name"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (email) {
        [params setObject:email forKey:@"email"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoeditContactInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)portalcommonInfoqueryContactInfosWithPageNum:(NSInteger)pageNum
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoqueryContactInfos parameters:params success:successBlock failure:failureBlock];
}
//END联系人  增 删 该 查
/*************************************************************************************************/

/*************************************************************************************************/
//地址  增 删 该 查
//receiverName	收件人姓名
//receiverMobile	收件号码
//province	省
//city	市
//area	区
//detailAddress	详细地址
//selfFlag	本人标志   @"0" 否   @"1"-是
- (void)portalcommonInfoaddAddressInfoWithreceiverName:(NSString *)receiverName
                                        receiverMobile:(NSString *)receiverMobile
                                         province:(NSString *)province
                                                  city:(NSString *)city
                                                  area:(NSString *)area
                                         detailAddress:(NSString *)detailAddress
                                              postCode:(NSString *)postCode
                                      selfFlag:(NSString *)selfFlag
                                      ssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (receiverName) {
        [params setObject:receiverName forKey:@"receiverName"];
    }
    if (receiverMobile) {
        [params setObject:receiverMobile forKey:@"receiverMobile"];
    }
    if (province) {
        [params setObject:province forKey:@"province"];
    }
    if (city) {
        [params setObject:city forKey:@"city"];
    }
    if (area) {
        [params setObject:area forKey:@"area"];
    }
    if (detailAddress) {
        [params setObject:detailAddress forKey:@"detailAddress"];
    }
    if (postCode) {
        [params setObject:postCode forKey:@"postCode"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoaddAddressInfo parameters:params success:successBlock failure:failureBlock];
}
//addressId	地址编号
- (void)portalcommonInfodeleteAddressInfoWithaddressId:(NSInteger)addressId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (addressId>0) {
        [params setObject:@(addressId) forKey:@"addressId"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfodeleteAddressInfo parameters:params success:successBlock failure:failureBlock];
}
//addressId	地址编号
//receiverName	收件人姓名
//receiverMobile	收件号码
//province	省
//city	市
//area	区
//detailAddress	详细地址
//selfFlag	本人标志
- (void)portalcommonInfoeditAddressInfoWithaddressId:(NSInteger )addressId
                                        receiverName:(NSString *)receiverName
                                      receiverMobile:(NSString *)receiverMobile
                                            province:(NSString *)province
                                                city:(NSString *)city
                                                area:(NSString *)area
                                       detailAddress:(NSString *)detailAddress
                                            postCode:(NSString *)postCode
                                            selfFlag:(NSString *)selfFlag
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (addressId>0) {
        [params setObject:@(addressId) forKey:@"addressId"];
    }
    if (receiverName) {
        [params setObject:receiverName forKey:@"receiverName"];
    }
    if (receiverMobile) {
        [params setObject:receiverMobile forKey:@"receiverMobile"];
    }
    if (province) {
        [params setObject:province forKey:@"province"];
    }
    if (city) {
        [params setObject:city forKey:@"city"];
    }
    if (area) {
        [params setObject:area forKey:@"area"];
    }
    if (detailAddress) {
        [params setObject:detailAddress forKey:@"detailAddress"];
    }
    if (postCode) {
        [params setObject:postCode forKey:@"postCode"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoeditAddressInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)portalcommonInfoqueryAddressInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoqueryAddressInfos parameters:params success:successBlock failure:failureBlock];
}
//END地址  增 删 该 查
/*************************************************************************************************/

/*************************************************************************************************/
//旅游  增 删 该 查
//name	姓名
//surname	英文姓  Must
//enName	英文名  Must
//mobile	电话
//sex	性别
//birthday	出生日期
//selfFlag	本人标志
//nationality	国籍
//certType	证件类型
//certNo	证件号码
//expireDate	证件有效期
- (void)commonInfoaddPassengerInfoWithname:(NSString *)name
                                   surname:(NSString *)surname
                                    enName:(NSString *)enName
                                    mobile:(NSString *)mobile
                                       sex:(NSString *)sex
                                  birthday:(NSString *)birthday
                                  selfFlag:(NSString *)selfFlag
                               nationality:(NSString *)nationality
                                  certType:(NSString *)certType
                                    certNo:(NSString *)certNo
                                expireDate:(NSString *)expireDate
                                  ssuccess:(RequestSuccess)successBlock
                                   failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (name) {
        [params setObject:name forKey:@"name"];
    }
    if (surname) {
        [params setObject:surname forKey:@"surname"];
    }
    if (enName) {
        [params setObject:enName forKey:@"enName"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (sex) {
        [params setObject:sex forKey:@"sex"];
    }
    if (birthday) {
        [params setObject:birthday forKey:@"birthday"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    if (nationality) {
        [params setObject:nationality forKey:@"nationality"];
    }
    if (certType) {
        [params setObject:certType forKey:@"certType"];
    }
    if (certNo) {
        [params setObject:certNo forKey:@"certNo"];
    }
    if (expireDate) {
        [params setObject:expireDate forKey:@"expireDate"];
    }
    [self postJsonWithPath:URLBASIC_commonInfoaddPassengerInfo parameters:params success:successBlock failure:failureBlock];
}
//passengerId	编号
- (void)commonInfodeletePassengerInfoWithpassengerId:(NSInteger)passengerId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (passengerId>0) {
        [params setObject:@(passengerId) forKey:@"passengerId"];
    }
    [self postJsonWithPath:URLBASIC_commonInfodeletePassengerInfo parameters:params success:successBlock failure:failureBlock];
}
//passengerId	编号
//name	姓名
//surname	英文姓  Must
//enName	英文名  Must
//mobile	电话
//sex	性别
//birthday	出生日期
//selfFlag	本人标志
//nationality	国籍
//certType	证件类型
//certNo	证件号码
//expireDate	证件有效期
- (void)commonInfoeditPassengerInfoWithpassengerId:(NSInteger)passengerId
                                              name:(NSString *)name
                                           surname:(NSString *)surname
                                            enName:(NSString *)enName
                                            mobile:(NSString *)mobile
                                               sex:(NSString *)sex
                                          birthday:(NSString *)birthday
                                          selfFlag:(NSString *)selfFlag
                                       nationality:(NSString *)nationality
                                          certType:(NSString *)certType
                                            certNo:(NSString *)certNo
                                        expireDate:(NSString *)expireDate
                                          ssuccess:(RequestSuccess)successBlock
                                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (passengerId>0) {
        [params setObject:@(passengerId) forKey:@"passengerId"];
    }
    if (name && name.length) {
        [params setObject:name forKey:@"name"];
    }
    if (surname && surname.length) {
        [params setObject:surname forKey:@"surname"];
    }
    if (enName && enName.length) {
        [params setObject:enName forKey:@"enName"];
    }
    if (mobile && mobile.length) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (sex && sex.length) {
        [params setObject:sex forKey:@"sex"];
    }
    if (birthday && birthday.length) {
        [params setObject:birthday forKey:@"birthday"];
    }
    if (selfFlag && selfFlag.length) {
        [params setObject:selfFlag forKey:@"selfFlag"];
    }
    if (nationality && nationality.length) {
        [params setObject:nationality forKey:@"nationality"];
    }
    if (certType && certType.length) {
        [params setObject:certType forKey:@"certType"];
    }
    if (certNo && certNo.length) {
        [params setObject:certNo forKey:@"certNo"];
    }
    if (expireDate && expireDate.length) {
        [params setObject:expireDate forKey:@"expireDate"];
    }
    [self postJsonWithPath:URLBASIC_commonInfoeditPassengerInfo parameters:params success:successBlock failure:failureBlock];
}
- (void)portalcommonInfoqueryPassengerInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum>0) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalcommonInfoqueryPassengerInfos parameters:params success:successBlock failure:failureBlock];
}
//END旅游  增 删 该 查
/*************************************************************************************************/

//chlType	登陆渠道类型
//nickname	昵称
//province	省份
//city	城市
//gender	性别
//avatar	头像
//country	国家
//openId
//unionid
- (void)userthirdUserLoginWithchlType:(NSString *)chlType
                             nickname:(NSString *)nickname
                             province:(NSString *)province
                                 city:(NSString *)city
                               gender:(NSString *)gender
                               avatar:(NSString *)avatar
                              country:(NSString *)country
                               openId:(NSString *)openId
                              unionid:(NSString *)unionid
                             ssuccess:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (chlType) {
        [params setObject:chlType forKey:@"chlType"];
    }
    if (nickname) {
        [params setObject:nickname forKey:@"nickname"];
    }
    if (province) {
        [params setObject:province forKey:@"province"];
    }
    if (city) {
        [params setObject:city forKey:@"city"];
    }
    if (gender) {
        [params setObject:gender forKey:@"gender"];
    }
    if (avatar) {
        [params setObject:avatar forKey:@"avatar"];
    }
    if (country) {
        [params setObject:country forKey:@"country"];
    }
    if (openId) {
        [params setObject:openId forKey:@"openId"];
    }
    if (unionid) {
        [params setObject:unionid forKey:@"unionid"];
    }
    [self postJsonWithPath:URLBASIC_userthirdUserLogin parameters:params success:successBlock failure:failureBlock];
}
//unionId	unionId
//mobile	手机号
//verifyCode	验证码
- (void)userthirdUserBindWithunionId:(NSString *)unionId
                             mobile:(NSString *)mobile
                             verifyCode:(NSString *)verifyCode
                             ssuccess:(RequestSuccess)successBlock
                              failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (unionId) {
        [params setObject:unionId forKey:@"unionId"];
    }
    if (mobile) {
        [params setObject:mobile forKey:@"mobile"];
    }
    if (verifyCode) {
        [params setObject:verifyCode forKey:@"verifyCode"];
    }
    [self postJsonWithPath:URLBASIC_userthirdUserBind parameters:params success:successBlock failure:failureBlock];
}

- (void)appsubmitFeedbackWithcontent:(NSString *)content
                            ssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (content) {
        [params setObject:content forKey:@"content"];
    }
    [self postJsonWithPath:URLBASIC_appsubmitFeedback parameters:params success:successBlock failure:failureBlock];
}

- (void)userlogoutssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_userlogout parameters:params success:successBlock failure:failureBlock];
}

- (void)portalqueryFinaProductsssuccess:(RequestSuccess)successBlock
                   failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [self postJsonWithPath:URLBASIC_portalqueryFinaProducts parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_usermodifyNicknameWithnickname:(NSString *)nickname
                                      sssuccess:(RequestSuccess)successBlock
                                failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (nickname) {
        [params setObject:nickname forKey:@"nickname"];
    }
    [self postJsonWithPath:URLBASIC_usermodifyNickname parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_userrefreshLoginWithnisssuccess:(RequestSuccess)successBlock
                                        failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([PortalHelper sharedInstance].userInfo.authenTicket) {
        [params setObject:[PortalHelper sharedInstance].userInfo.authenTicket forKey:@"ticket"];
    }
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)[NSDate date].timeIntervalSince1970];
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    [self postJsonWithPath:URLBASIC_userrefreshLogin parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_portalqueryOrderInfoWithsysId:(NSString *)sysId
                                          sign:(NSString *)sign
                                     timestamp:(NSString *)timestamp
                                             v:(NSString *)v
                                       orderId:(NSString *)orderId
                                     sssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (sysId) {
        [params setObject:sysId forKey:@"sysId"];
    }
    if (sign) {
        [params setObject:sign forKey:@"sign"];
    }
    if (timestamp) {
        [params setObject:timestamp forKey:@"timestamp"];
    }
    if (v) {
        [params setObject:v forKey:@"v"];
    }
    if (orderId) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [self postJsonWithPath:URLBASIC_portalqueryOrderInfo parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_portaladdFavoriteWithmerchId:(NSString *)merchId
                                          title:(NSString *)title
                                     url:(NSURL *)url
                                     sssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (merchId) {
        [params setObject:merchId forKey:@"merchId"];
    }
    if (title) {
        [params setObject:title forKey:@"title"];
    }
    if (url) {
        [params setObject:[url absoluteString] forKey:@"url"];
    }
    [self postJsonWithPath:URLBASIC_portaladdFavorite parameters:params success:successBlock failure:failureBlock];
}

- (void)URLBASIC_portalqueryFavoritesWithPageNum:(NSInteger)pageNum
                                    sssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (pageNum) {
        [params setObject:@(pageNum) forKey:@"pageNum"];
    }
    [self postJsonWithPath:URLBASIC_portalqueryFavorites parameters:params success:successBlock failure:failureBlock];
}
- (void)URLBASIC_portalcancelFavoriteWithlist:(NSArray *)list
                                       sssuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (list) {
        [params setObject:list forKey:@"list"];
    }
    [self postJsonWithPath:URLBASIC_portalcancelFavorite parameters:params success:successBlock failure:failureBlock];
}

@end
