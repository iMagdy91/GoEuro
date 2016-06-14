//
//  Utils.m
//  GoEuro
//
//  Created by Mohamed Magdy on 6/13/16.
//  Copyright © 2016 Magdy. All rights reserved.
//

#import "Utils.h"
#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import "APIManager.h"

@implementation Utils


+(NSArray*) sortLocationsByNearest:(NSMutableArray*)locations {
    for (Locations *location in locations){
        CLLocation *currentLoc = [APIManager sharedInstance].usersLocation;
        CLLocation *cityLoc = [[CLLocation alloc] initWithLatitude:location.geo_position.latitude longitude:location.geo_position.longitude];
        CLLocationDistance meters = [cityLoc distanceFromLocation:currentLoc];
        location.distanceFromMe = [NSNumber numberWithDouble:meters];
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distanceFromMe"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [locations sortedArrayUsingDescriptors:sortDescriptors];
    
    return sortedArray;
}

@end
