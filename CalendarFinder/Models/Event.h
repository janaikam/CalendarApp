//
//  Event.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Location.h"

NS_ASSUME_NONNULL_BEGIN

@interface Event : PFObject <PFSubclassing>

@property (nonatomic, copy, readonly) NSString *eventID;
@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, strong, readonly) PFUser *author;

@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *eventDescription;
@property (nonatomic, strong) NSNumber *attendeesCount;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSMutableArray *attendees;

- (instancetype) initWithImage:(UIImage *)image
                     eventName:(NSString *)eventName
                   description:(NSString *)eventDescription
                     startTime:(NSDate *)startTime
                       endTime:(NSDate *)endTime
                      location:(NSString *)location
                    completion:(PFBooleanResultBlock)completion;

+ (void) postUserEvent: ( UIImage * _Nullable )image
             eventName: ( NSString * _Nullable )eventName
           description: ( NSString * _Nullable ) eventDescription
             startTime: ( NSDate * _Nullable ) startTime
               endTime: ( NSDate * _Nullable ) endTime
              location: (NSString* _Nullable)location
            completion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
