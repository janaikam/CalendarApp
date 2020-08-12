//
//  Event.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

// Creates an event object and sends the information to Parse. Adds attendees to a relation in Parse.
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
@property (nonatomic, strong) NSNumber *userLocDist;


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

- (void) connectEventAttendees: (Event *) event
                          user: (PFUser *) user
                withCompletion: (PFBooleanResultBlock)completion;


- (NSComparisonResult)compareEvents: (Event *)eventCompare;

+ (NSMutableArray *) sortedEvent: (NSMutableArray *) eventArray;


- (void) setEvent: (Event *)event
 withUserDistance: (NSNumber *)distance;

+ (void) updateEvent: (Event * )event
           withImage:(UIImage *)image
           eventName: (NSString * _Nullable)eventName
         description: (NSString * _Nullable)description
           startTime: (NSDate * _Nullable)startTime
             endTime: (NSDate * _Nullable)endTime
          completion: (PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
