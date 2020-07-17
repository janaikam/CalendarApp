//
//  Location.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize locationID = _locationID;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize locationName = _locationName;

- (instancetype) initWithString:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        _locationName = name;
        _latitude = latitude;
        _longitude = longitude;
        
    }
    return self;
}

+ (nonnull NSString *)parseClassName {
    return @"Location";
}

+ (void) createLocation:(NSString *)name latitude:(NSNumber *)latitude longitutde:(NSNumber *)longitude completion:(PFBooleanResultBlock)completion{
    
    Location *newLocation = [[Location alloc] initWithString:name latitude:latitude longitude:longitude completion:completion];
    [newLocation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"success!");
    }];
};
@end
