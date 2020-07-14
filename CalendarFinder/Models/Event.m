//
//  Event.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Event.h"

@implementation Event

@dynamic  eventID;
@dynamic userID;
@dynamic author;
@dynamic eventName;
@dynamic eventDescription;
@dynamic attendeesCount;
@dynamic startTime;
@dynamic endTime;
@dynamic eventImage;

+ (nonnull NSString *)parseClassName {
    return @"Event";
}

+ (void) postUserEvent:(UIImage *)image withEventName:(NSString *)eventName withDescription:(NSString *)eventDescription withStartTime:(NSDate *)startTime withEndTime:(NSDate *)endTime withCompletion:(PFBooleanResultBlock)completion{
    
    Event *newEvent= [Event new];
    newEvent.eventImage = [self getPFFileFromImage:image];
    newEvent.author = [PFUser currentUser];
    newEvent.eventName = eventName;
    newEvent.eventDescription = eventDescription;
    newEvent.startTime = startTime;
    newEvent.endTime = endTime;
    newEvent.attendeesCount = @(0);
    
    [newEvent saveInBackgroundWithBlock:completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
