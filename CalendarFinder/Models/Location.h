//
//  Location.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Location : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

@end

NS_ASSUME_NONNULL_END
