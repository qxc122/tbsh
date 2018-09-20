//
//  ToolModeldata.m
//  TourismT
//
//  Created by Store on 16/12/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ToolModeldata.h"
#import "MJExtension.h"
/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
//+ (NSDictionary *)mj_replacedKeyFromPropertyName;

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 从字典中取值用的key
 */
//+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName;


/**
 *  旧值换新值，用于过滤字典中的值
 *
 *  @param oldValue 旧值
 *
 *  @return 新值
 */
//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property;
//    if ([property.name isEqualToString:@"publisher"]) {
//        if (oldValue == nil) return @"";
//    } else if (property.type.typeClass == [NSDate class]) {
//        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//        fmt.dateFormat = @"yyyy-MM-dd";
//        return [fmt dateFromString:oldValue];
//    }  

//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
//    return @{
//             @"contentA" : @"content",
//             @"pageableD" : @"pageable",
//             };
//}
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{
//             @"contentA" : @"contentS",
//             };
//}


@implementation appIdAndSecret
MJExtensionCodingImplementation

@end

@implementation accessToken
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"expireTime"]) {
        if (oldValue && [oldValue isKindOfClass:[NSNumber class]]) {
            return [NSDate dateWithTimeIntervalSinceNow:[oldValue integerValue]];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation UserInfo
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"headUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            }else{
                return nil;
            }
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end


@implementation GlobalParameter
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"backgroundImg"] || [property.name isEqualToString:@"userAgreementUrl"] || [property.name isEqualToString:@"privacyAgreementUrl"] || [property.name isEqualToString:@"serviceAgreementUrl"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation HomeData
MJExtensionCodingImplementation
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_merchList" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_merchList" : @"HomeDataOne",
             };
}
@end


@implementation HomeDataOne
MJExtensionCodingImplementation
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"merchIcon"] || [property.name isEqualToString:@"merchLink"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"needLogin"]) {
        if ([oldValue isKindOfClass:[NSString class]]) {
            if ([oldValue isEqualToString:@"1"]) {
                return @YES;
            } else if ([oldValue isEqualToString:@"0"]) {
                return @NO;
            }else{
                return @YES;
            }
        } else {
            return @YES;
        }
    }
    return oldValue;
}
@end

@implementation leftData


@end

@implementation MyNewsData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_newsList" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_newsList" : @"MyNewsData_One",
             };
}
@end

@implementation MyNewsData_One
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"newsLink"] || [property.name isEqualToString:@"newsImg"]  ) {  
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end

@implementation MyCollecData
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_List" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_List" : @"MyCollecData_One",
             };
}
@end

@implementation MyCollecData_One
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"url"] || [property.name isEqualToString:@"logo"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
@end



@implementation FinanceVcData
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"fundProductPicture"] || [property.name isEqualToString:@"fundProductLink"]  || [property.name isEqualToString:@"vcProductLink"] || [property.name isEqualToString:@"vcProductPicture"]  ) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            return [NSURL URLWithString:oldValue];
        } else {
            return nil;
        }
    }
    return oldValue;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_insuranceProductList" : @"insuranceProductList",
             @"Arry_tourProductList" : @"tourProductList",
             @"Arry_tpurseProductList" : @"tpurseProductList",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_insuranceProductList" : @"FinanceVcData_One",
             @"Arry_tourProductList" : @"FinanceVcData_One",
             @"Arry_tpurseProductList" : @"FinanceVcData_One",
             };
}
@end

@implementation FinanceVcData_One
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"productLink"] || [property.name isEqualToString:@"productPicture"]) {
        if (oldValue && [oldValue isKindOfClass:[NSString class]]) {
            NSString *tmp = oldValue;
            if (tmp.length) {
                return [NSURL URLWithString:oldValue];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    }else if ([property.name isEqualToString:@"needLogin"]) {
        if ([oldValue isKindOfClass:[NSString class]]) {
            if ([oldValue isEqualToString:@"1"]) {
                return @YES;
            } else if ([oldValue isEqualToString:@"0"]) {
                return @NO;
            }else{
                return @YES;
            }
        } else {
            return @YES;
        }
    }
    return oldValue;
}
@end

@implementation passengerInfos
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_passengerInfos" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_passengerInfos" : @"passengerInfos_one",
             };
}
@end

@implementation passengerInfos_one
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_certInfos" : @"certInfos",
             @"nationalityCode" : @"nationality",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_certInfos" : @"certInfos_one",
             };
}
- (id)copyWithZone:(NSZone *)zone
{
    passengerInfos_one *cpyPerson = [[passengerInfos_one allocWithZone:zone] init];
    cpyPerson.enName = self.enName;
    cpyPerson.mobile = self.mobile;
    cpyPerson.passengerId = self.passengerId;
    cpyPerson.selfFlag = self.selfFlag;
    cpyPerson.surname = self.surname;
    cpyPerson.birthday = self.birthday;
    cpyPerson.sex = self.sex;
    cpyPerson.name = self.name;
    cpyPerson.Arry_certInfos = [self.Arry_certInfos mutableCopy];
    return cpyPerson;
}
@end

@implementation certInfos_one
- (id)copyWithZone:(NSZone *)zone
{
    certInfos_one *cpyPerson = [[certInfos_one allocWithZone:zone] init];
    cpyPerson.certNo = self.certNo;
    cpyPerson.nationality = self.nationality;
    cpyPerson.certType = self.certType;
    cpyPerson.certId = self.certId;
    cpyPerson.expireDate = self.expireDate;
    return cpyPerson;
}
@end




@implementation contactInfos
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_contactInfos" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_contactInfos" : @"contactInfos_one",
             };
}
@end


@implementation addressInfos
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"Arry_addressInfos" : @"list",
             };
}
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"Arry_addressInfos" : @"addressInfos_one",
             };
}
@end

@implementation contactInfos_one
- (id)copyWithZone:(NSZone *)zone
{
    contactInfos_one *cpyPerson = [[contactInfos_one allocWithZone:zone] init];
    cpyPerson.email = self.email;
    cpyPerson.contactId = self.contactId;
    cpyPerson.mobile = self.mobile;
    cpyPerson.name = self.name;
    cpyPerson.userId = self.userId;
    cpyPerson.selfFlag = self.selfFlag;
    return cpyPerson;
}
@end
@implementation addressInfos_one
- (id)copyWithZone:(NSZone *)zone
{
    addressInfos_one *cpyPerson = [[addressInfos_one allocWithZone:zone] init];
    cpyPerson.receiverMobile = self.receiverMobile;
    cpyPerson.area = self.area;
    cpyPerson.city = self.city;
    cpyPerson.addressId = self.addressId;
    cpyPerson.receiverName = self.receiverName;
    cpyPerson.selfFlag = self.selfFlag;
    cpyPerson.userId = self.userId;
    cpyPerson.detailAddress = self.detailAddress;
    cpyPerson.province = self.province;
    cpyPerson.postCode = self.postCode;
    return cpyPerson;
}
@end
@implementation CheckApp
@end

@implementation setUp
MJExtensionCodingImplementation
@end

@implementation payPre

@end

@implementation payData

@end

