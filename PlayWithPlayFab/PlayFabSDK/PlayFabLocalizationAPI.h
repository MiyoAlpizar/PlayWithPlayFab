#import <Foundation/Foundation.h>

#import "PlayFabLocalizationDataModels.h"
#import "PlayFabError.h"
#import "PlayFabSettings.h"
#import "PlayFabClientAPI.h"


@interface PlayFabLocalizationAPI : NSObject

+(NSString*) GetURL;


		
typedef void(^GetLanguageListCallback)(LocalizationGetLanguageListResponse* result, NSObject* userData);
		

+ (PlayFabClientAPI*) GetInstance;

		

// ------------ Generated API calls
		
-(void) GetLanguageList:(LocalizationGetLanguageListRequest*)request success:(GetLanguageListCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		

@end
