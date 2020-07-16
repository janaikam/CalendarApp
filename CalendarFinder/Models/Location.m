//
//  Location.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Location.h"

@implementation Location

@dynamic latitude;
@dynamic longitude;
@dynamic locationName;

+ (nonnull NSString *)parseClassName {
    return @"Location";
}

@end
