//
//  Venue.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/24/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Venue : NSObject

@property(nonatomic, strong, readonly) NSNumber *latitude;
@property(nonatomic, strong, readonly) NSNumber *longitude;
@property(nonatomic, copy, readonly) NSString *name;

-(instancetype)initWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
