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
@property (nonatomic, copy, readwrite) NSString *location;
@property (nonatomic, strong, readwrite) NSNumber *latitude;
@property (nonatomic, strong, readwrite) NSNumber *longitude;

@end

@implementation Location

@dynamic locationID;
@dynamic latitude;
@dynamic longitude;
@dynamic location;


+ (nonnull NSString *)parseClassName {
    return @"Location";
}

- (instancetype) initWithString:(NSString *)name latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        self.location = name;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}



+ (void) createLocation:(NSString *)name latitude:(NSNumber *)latitude longitutde:(NSNumber *)longitude completion:(PFBooleanResultBlock)completion{
    PFQuery *locationQuery = [Location query];
    [locationQuery whereKey:@"location" containsString:name];
    locationQuery.limit = 1;
    
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray<Location *> * _Nullable objects, NSError * _Nullable error) {
        if (objects.count > 0){
            NSLog(@"Location exsits");
            Location *location = objects[0];
            [location saveInBackgroundWithBlock:completion];
            
        }else{
            Location *newLocation = [[Location alloc] initWithString:name latitude:latitude longitude:longitude completion:completion];

            [newLocation saveInBackgroundWithBlock:completion];
        }
    }];
    
    

};
@end
