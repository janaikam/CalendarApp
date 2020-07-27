//
//  User.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/15/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;
@dynamic currentLatitude;
@dynamic currentLongitude;

- (instancetype)initWithString:(NSString *)userName completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        self.username = userName;
    }
    return self;
}

+ (nonnull NSString *)parseClassName {
    return @"User";
}

@end
