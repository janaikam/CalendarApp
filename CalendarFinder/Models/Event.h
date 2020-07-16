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

@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSNumber *attendeesCount;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic, strong) PFFileObject *eventImage;
@property (nonatomic, strong) Location *location;


+ (void) postUserEvent: ( UIImage * _Nullable )image withEventName: ( NSString * _Nullable )eventName withDescription: ( NSString * _Nullable ) eventDescription withStartTime: ( NSDate * _Nullable ) startTime withEndTime: ( NSDate * _Nullable ) endTime withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
