//
//  User.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/15/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize username = _username;

- (instancetype)initWithString:(NSString *)userName completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        _username = userName;
    }
    return self;
}

+ (nonnull NSString *)parseClassName {
    return @"User";
}

@end
