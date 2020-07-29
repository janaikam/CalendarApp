//
//  Venue.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/24/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Venue.h"

@implementation Venue


-(instancetype)initWithData:(NSDictionary *)data{
    if (self == [super init]) {
        _data = data;
    }
    return self;
}

-(NSNumber *)latitude {
    return _data[@"location.lat"];
}

-(NSNumber *)longitude {
    return _data[@"location.lon"];
}

-(NSString *)name {
    return _data[@"name"];
}

-(NSString *)address {
    return [_data valueForKeyPath:@"location.address"];
}

@end
