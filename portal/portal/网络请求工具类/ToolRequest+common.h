//
//  ToolRequest+common.h
//  TourismT
//
//  Created by Store on 16/11/21.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolRequest.h"

#define  LOGIN_TYPE @"01"

#define   STRING_0 @"0"
#define   STRING_1 @"1"

#define   PASSENGER_TYPE_NI @"NI" //身份证
#define   PASSENGER_TYPE_P @"P"    //护照
#define   PASSENGER_TYPE_ID @"ID"  //其他证件

#define   SEX_WOMAN @"F" //性别女
#define   SEX_MAN @"M"    //性别男

@interface ToolRequest (common)
- (void)tpurseappappIdApplysuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock;

- (void)apptokenApplysuccess:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock;

- (void)appgetGlobalParamssuccess:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;

- (void)portalqueryMerchListssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;

- (void)systemsendVerifyCodeWithmobile:(NSString *)mobile
                                  type:(NSString *)type
                               success:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock;

- (void)URLBASIC_appappUpdatesuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;
    
- (void)userloginWithmobile:(NSString *)mobile
                 verifyCode:(NSString *)verifyCode
                    success:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock;

- (void)usermyInfosuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock;

- (void)portalusermyNewWithPageNum:(NSInteger)pageNum
                          ssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock;


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
                                       failure:(RequestFailure)failureBlock;
//contactId	联系人编号
- (void)portalcommonInfodeleteContactInfoWithcontactId:(NSInteger)contactId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
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
                                             failure:(RequestFailure)failureBlock;
- (void)portalcommonInfoqueryContactInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
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
                                               failure:(RequestFailure)failureBlock;
//addressId	地址编号
- (void)portalcommonInfodeleteAddressInfoWithaddressId:(NSInteger)addressId
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
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
                                             failure:(RequestFailure)failureBlock;
- (void)portalcommonInfoqueryAddressInfosWithPageNum:(NSInteger)pageNum
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
//END地址  增 删 该 查
/*************************************************************************************************/

/*************************************************************************************************/
//旅客  增 删 该 查
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
                                   failure:(RequestFailure)failureBlock;
//passengerId	编号
- (void)commonInfodeletePassengerInfoWithpassengerId:(NSInteger)passengerId
                                            ssuccess:(RequestSuccess)successBlock
                                             failure:(RequestFailure)failureBlock;
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
                                           failure:(RequestFailure)failureBlock;
- (void)portalcommonInfoqueryPassengerInfosWithPageNum:(NSInteger)pageNum
                                              ssuccess:(RequestSuccess)successBlock
                                               failure:(RequestFailure)failureBlock;
//END旅客   增 删 该 查
/*************************************************************************************************/

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
                              failure:(RequestFailure)failureBlock;

- (void)userthirdUserBindWithunionId:(NSString *)unionId
                              mobile:(NSString *)mobile
                          verifyCode:(NSString *)verifyCode
                            ssuccess:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;

- (void)appsubmitFeedbackWithcontent:(NSString *)content
                                     ssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)userlogoutssuccess:(RequestSuccess)successBlock
                   failure:(RequestFailure)failureBlock;

- (void)portalqueryFinaProductsssuccess:(RequestSuccess)successBlock
                                failure:(RequestFailure)failureBlock;

- (void)URLBASIC_usermodifyNicknameWithnickname:(NSString *)nickname
                                      sssuccess:(RequestSuccess)successBlock
                                        failure:(RequestFailure)failureBlock;

- (void)URLBASIC_userrefreshLoginWithnisssuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portalqueryOrderInfoWithsysId:(NSString *)sysId
                                          sign:(NSString *)sign
                                     timestamp:(NSString *)timestamp
                                             v:(NSString *)v
                                       orderId:(NSString *)orderId
                                     sssuccess:(RequestSuccess)successBlock
                                       failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portaladdFavoriteWithmerchId:(NSString *)merchId
                                        title:(NSString *)title
                                          url:(NSURL *)url
                                    sssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portalqueryFavoritesWithPageNum:(NSInteger)pageNum
                                       sssuccess:(RequestSuccess)successBlock
                                         failure:(RequestFailure)failureBlock;

- (void)URLBASIC_portalcancelFavoriteWithlist:(NSArray *)list
                                    sssuccess:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;
@end
