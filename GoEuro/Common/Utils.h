//
//  Utils.h
//  GoEuro
//
//  Created by Mohamed Magdy on 6/13/16.
//  Copyright © 2016 Magdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


+(NSArray*) sortLocationsByNearest:(NSMutableArray*)locations;
+ (NSString *)urlencode:(NSString*)url;
@end
