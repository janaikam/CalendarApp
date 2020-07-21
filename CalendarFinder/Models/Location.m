//
//  Location.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Location.h"

@interface Location()

@property (nonatomic, copy, readwrite) NSString *locationID;
@property (nonatomic, copy, readwrite) NSString *locationName;
@property (nonatomic, strong, readwrite) NSNumber *latitude;
@property (nonatomic, strong, readwrite) NSNumber *longitude;

@end

@implementation Location

@dynamic locationID;
@dynamic latitude;
@dynamic longitude;
@dynamic locationName;


+ (nonnull NSString *)parseClassName {
    return @"Location";
}

- (instancetype) initWithString:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        self.locationName = name;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}



+ (void) createLocation:(NSString *)name latitude:(NSNumber *)latitude longitutde:(NSNumber *)longitude completion:(PFBooleanResultBlock)completion{
    
    Location *newLocation = [[Location alloc] initWithString:name latitude:latitude longitude:longitude completion:completion];

    [newLocation saveInBackgroundWithBlock:completion];

};
@end
