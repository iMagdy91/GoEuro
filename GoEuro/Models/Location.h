//
//  Location.h
//  GoEuro
//
//  Created by Mohamed Magdy on 6/9/16.
//  Copyright © 2016 Magdy. All rights reserved.
//

#import "JSONModel.h"

@protocol Locations
@end

@interface AlternativeNames : JSONModel

@end

@interface Position : JSONModel

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@end

@interface Names : JSONModel

@property (nonatomic,strong) NSString <Optional> *pt;
@property (nonatomic,strong) NSString <Optional> *fr;
@property (nonatomic,strong) NSString <Optional> *es;
@property (nonatomic,strong) NSString <Optional> *ru;
@property (nonatomic,strong) NSString <Optional> *it;
@property (nonatomic,strong) NSString <Optional> *is;
@property (nonatomic,strong) NSString <Optional> *fi;
@property (nonatomic,strong) NSString <Optional> *zh;
@property (nonatomic,strong) NSString <Optional> *cs;
@property (nonatomic,strong) NSString <Optional> *ca;


@end

@interface Locations : JSONModel

@property (nonatomic) int _id;
@property (nonatomic,strong) AlternativeNames <Optional> *alternativeNames;
@property (nonatomic) BOOL coreCountry;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *countryCode;
@property (nonatomic) int countryId;
@property (nonatomic,strong) NSString <Optional> *distance;
@property (nonatomic,strong) Position *geo_position;
@property (nonatomic,strong) NSString <Optional> *iata_airport_code;
@property (nonatomic) BOOL inEurope;
@property (nonatomic,strong) NSString <Optional> *key;
@property (nonatomic,strong) NSString <Optional> *locationId;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) Names <Optional> *names;
@property (nonatomic,strong) NSString *type;
@property (nonatomic) NSNumber <Optional> *distanceFromMe;

@end

@interface Location : JSONModel

@property (nonatomic,strong) NSArray <Locations>* locations;

@end

