//
//  Venue.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/24/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Creates a venue object for the location view controller to pull from
@interface Venue : NSObject

@property(nonatomic, strong) NSDictionary *data;

@property(nonatomic, strong, readonly) NSNumber *latitude;
@property(nonatomic, strong, readonly) NSNumber *longitude;
@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *address;

-(instancetype)initWithData:(NSDictionary *)data;



@end

NS_ASSUME_NONNULL_END
