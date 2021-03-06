#import <Foundation/Foundation.h>

#import "PlayFabExperimentationDataModels.h"
#import "PlayFabError.h"
#import "PlayFabSettings.h"
#import "PlayFabClientAPI.h"


@interface PlayFabExperimentationAPI : NSObject

+(NSString*) GetURL;


		
typedef void(^CreateExclusionGroupCallback)(ExperimentationCreateExclusionGroupResult* result, NSObject* userData);
		
typedef void(^CreateExperimentCallback)(ExperimentationCreateExperimentResult* result, NSObject* userData);
		
typedef void(^DeleteExclusionGroupCallback)(ExperimentationEmptyResponse* result, NSObject* userData);
		
typedef void(^DeleteExperimentCallback)(ExperimentationEmptyResponse* result, NSObject* userData);
		
typedef void(^GetExclusionGroupsCallback)(ExperimentationGetExclusionGroupsResult* result, NSObject* userData);
		
typedef void(^GetExclusionGroupTrafficCallback)(ExperimentationGetExclusionGroupTrafficResult* result, NSObject* userData);
		
typedef void(^GetExperimentsCallback)(ExperimentationGetExperimentsResult* result, NSObject* userData);
		
typedef void(^GetLatestScorecardCallback)(ExperimentationGetLatestScorecardResult* result, NSObject* userData);
		
typedef void(^GetTreatmentAssignmentCallback)(ExperimentationGetTreatmentAssignmentResult* result, NSObject* userData);
		
typedef void(^StartExperimentCallback)(ExperimentationEmptyResponse* result, NSObject* userData);
		
typedef void(^StopExperimentCallback)(ExperimentationEmptyResponse* result, NSObject* userData);
		
typedef void(^UpdateExclusionGroupCallback)(ExperimentationEmptyResponse* result, NSObject* userData);
		
typedef void(^UpdateExperimentCallback)(ExperimentationEmptyResponse* result, NSObject* userData);
		

+ (PlayFabClientAPI*) GetInstance;

		

// ------------ Generated API calls
		
-(void) CreateExclusionGroup:(ExperimentationCreateExclusionGroupRequest*)request success:(CreateExclusionGroupCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) CreateExperiment:(ExperimentationCreateExperimentRequest*)request success:(CreateExperimentCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) DeleteExclusionGroup:(ExperimentationDeleteExclusionGroupRequest*)request success:(DeleteExclusionGroupCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) DeleteExperiment:(ExperimentationDeleteExperimentRequest*)request success:(DeleteExperimentCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetExclusionGroups:(ExperimentationGetExclusionGroupsRequest*)request success:(GetExclusionGroupsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetExclusionGroupTraffic:(ExperimentationGetExclusionGroupTrafficRequest*)request success:(GetExclusionGroupTrafficCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetExperiments:(ExperimentationGetExperimentsRequest*)request success:(GetExperimentsCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetLatestScorecard:(ExperimentationGetLatestScorecardRequest*)request success:(GetLatestScorecardCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) GetTreatmentAssignment:(ExperimentationGetTreatmentAssignmentRequest*)request success:(GetTreatmentAssignmentCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) StartExperiment:(ExperimentationStartExperimentRequest*)request success:(StartExperimentCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) StopExperiment:(ExperimentationStopExperimentRequest*)request success:(StopExperimentCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateExclusionGroup:(ExperimentationUpdateExclusionGroupRequest*)request success:(UpdateExclusionGroupCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		
-(void) UpdateExperiment:(ExperimentationUpdateExperimentRequest*)request success:(UpdateExperimentCallback)callback failure:(ErrorCallback)errorCallback withUserData:(NSObject*)userData;
		

@end
