//
//  PlayFabVersion.m
//  PlayFabSDK
//
//  Created by Jackdaw on 11/12/15.
//  Copyright © 2015 PlayFab, Inc. All rights reserved.
//

#import "PlayFabSettings.h"

#ifdef USE_IDFA
@import AdSupport;
#endif

static NSString * TitleId = @"62E19";

static NSString * DeveloperSecretKey = @"";

static NSString * ProductionEnvironmentURL = @".playfabapi.com";

NSString * const AD_TYPE_IDFA = @"Idfa";
NSString * const AD_TYPE_ANDROID_ID = @"Adid";
static NSString * AdvertisingIdType;
static NSString * AdvertisingIdValue;
static NSString * VerticalName;

@implementation PlayFabSettings

+ (NSString *) ProductionEnvironmentURL
{
    return ProductionEnvironmentURL;
}
+ (NSString *) TitleId
{
    return TitleId;
}
+ (NSString *) DeveloperSecretKey
{
    return DeveloperSecretKey;
}
+ (NSString *) AdvertisingIdType
{
    return AdvertisingIdType;
}
+ (NSString *) AdvertisingIdValue
{
    return AdvertisingIdValue;
}
+ (NSString *) VerticalName
{
    return VerticalName;
}


+ (void) setProductionEnvironmentURL:(NSString*)setValue
{
    ProductionEnvironmentURL = setValue;
}
+ (void) setTitleId:(NSString*)setValue
{
    TitleId = setValue;
}
+ (void) setDeveloperSecretKey:(NSString*)setValue
{
    DeveloperSecretKey = setValue;
}
+ (void) setAdvertisingIdType:(NSString*)setValue
{
    AdvertisingIdType = setValue;
}
+ (void) setAdvertisingIdValue:(NSString*)setValue
{
    AdvertisingIdValue = setValue;
}

+ (void) setVerticalName:(NSString *)setValue
{
     VerticalName = setValue;
}


#ifdef USE_IDFA
+ (NSString *)identifierForAdvertising
{
    if([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        NSUUID *IDFA = [[ASIdentifierManager sharedManager] advertisingIdentifier];
        
        return [IDFA UUIDString];
    }
    
    return nil;
}
#endif


@end
