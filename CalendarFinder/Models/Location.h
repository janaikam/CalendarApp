//
//  Location.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

//Adds a location for events to connect to, so they can be viewed on the map.
@interface Location : PFObject <PFSubclassing>

@property (nonatomic, copy, readonly) NSString *locationID;
@property (nonatomic, copy, readonly) NSString *location;
@property (nonatomic, strong, readonly) NSNumber *latitude;
@property (nonatomic, strong, readonly) NSNumber *longitude;


- (instancetype) initWithString: (NSString * _Nullable)name
                       latitude: (NSNumber * _Nullable)latitude
                      longitude: (NSNumber * _Nullable) longitude
                     completion: (PFBooleanResultBlock _Nullable) completion;

+ (void) createLocation: ( NSString * _Nullable ) name
               latitude: ( NSNumber * _Nullable ) latitude
             longitutde: (NSNumber * _Nullable ) longitude
             completion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
