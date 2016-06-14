//
//  APIManager.m
//  GoEuro
//
//  Created by Mohamed Magdy on 6/8/16.
//  Copyright © 2016 Magdy. All rights reserved.
//

#import "APIManager.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "Location.h"
#import "Utils.h"

@implementation APIManager

static APIManager *sharedInstance = nil;

+(instancetype) sharedInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[APIManager alloc] init];
    }
    return sharedInstance;
}


-(void) getCitiesForSearchText:(NSString*)searchText
                   withSuccess:(networkSuccessBlock)success
                       failure:(networkFailureBlock)failure {
    
    NSString * language = [[NSLocale preferredLanguages] firstObject];
    NSString *url = [NSString stringWithFormat:APIURL,language,searchText];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSError *error;
        NSMutableArray *locations = [Locations arrayOfModelsFromDictionaries:responseObject error:&error];
        Location *location = [[Location alloc]init];
        location.locations = (NSArray<Locations>*)[Utils sortLocationsByNearest:locations];
        if (error)
            failure(error);
        else
            success(location);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}



@end
