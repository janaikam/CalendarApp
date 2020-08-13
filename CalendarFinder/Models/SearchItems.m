//
//  SearchItems.m
//  CalendarFinder
//
//  Created by Janai Kameka on 8/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "SearchItems.h"

@implementation SearchItems

-(instancetype)initWithMKMapItem:(MKMapItem *)mapItem{
    if (self == [super init]) {
        _mapItem = mapItem;
    }
    return self;
}

-(NSString *)name{
    return [_mapItem name];
}

-(MKPlacemark *)placemark{
    return [_mapItem placemark];
}

-(NSNumber *)longitude{
    NSNumber *number = [[NSNumber alloc] initWithDouble:[[_mapItem placemark] coordinate].longitude];
    return number;
}

-(NSNumber *)latitude{
    NSNumber *number = [[NSNumber alloc] initWithDouble:[[_mapItem placemark] coordinate].latitude];
    return number;
}

@end
