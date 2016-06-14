//
//  APIManager.h
//  GoEuro
//
//  Created by Mohamed Magdy on 6/8/16.
//  Copyright © 2016 Magdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import <CoreLocation/CoreLocation.h>

typedef void (^networkSuccessBlock)(Location* location);
typedef void (^networkFailureBlock)(NSError* error);

@interface APIManager : NSObject


@property (nonatomic) CLLocation *usersLocation;
+(instancetype) sharedInstance;
-(void) getCitiesForSearchText:(NSString*)searchText
                   withSuccess:(networkSuccessBlock)success
                       failure:(networkFailureBlock)failure;

@end
