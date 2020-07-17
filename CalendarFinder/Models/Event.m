//
//  Event.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Event.h"

@implementation Event

//@dynamic  eventID;
//@dynamic userID;
//@dynamic author;
//@dynamic eventDescription;
//@dynamic attendeesCount;
//@dynamic startTime;
//@dynamic endTime;
//@dynamic eventImage;
//@dynamic location;

@synthesize eventName = _eventName;
@synthesize eventID = _eventID;
@synthesize userID = _userID;
@synthesize author = _author;
@synthesize eventDescription = _eventDescription;
@synthesize attendeesCount = _attendeesCount;
@synthesize startTime = _startTime;
@synthesize endTime = _endTime;
@synthesize eventImage = _eventImage;
@synthesize location = _location;

- (instancetype) initWithImage:(UIImage *)image
                 eventName:(NSString *)eventName
               description:(NSString *)eventDescription
                 startTime:(NSDate *)startTime
                   endTime:(NSDate *)endTime
                  location:(NSString *)location
        completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        
        _eventName = eventName;
        _author = [PFUser currentUser];
        _eventImage = [self.class getPFFileFromImage:image];
        _eventDescription = eventDescription;
        _startTime = startTime;
        _endTime = endTime;
        _location = location;
    }
    return self;
}

+ (nonnull NSString *)parseClassName {
    return @"Event";
}

+ (void) postUserEvent:(UIImage *)image eventName:(NSString *)eventName description:(NSString *)eventDescription startTime:(NSDate *)startTime endTime:(NSDate *)endTime location:(NSString *)location completion:(PFBooleanResultBlock)completion{
    
    Event *newEvent= [[Event alloc] initWithImage:image eventName:eventName description:eventDescription startTime:startTime endTime:endTime location:location completion:completion];
    
    [newEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error){
            [newEvent connectEventLocation:newEvent withLocation:location withCompletion:completion];
        }
    }];
}

- (void) connectEventLocation: ( Event * _Nullable)event withLocation: ( NSString * _Nullable) locationName withCompletion: (PFBooleanResultBlock)completion{
    PFQuery *locationQuery = [Location query];
    [locationQuery whereKey:@"locationName" equalTo:locationName];
    locationQuery.limit = 1;
    
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error){
            Location *location = objects[0];
            PFRelation *relation = [location relationForKey:@"location"];
            [relation addObject:event];
            [location saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded){
                    [event saveInBackgroundWithBlock:completion];
                }
            }];
            
        }
    }];
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
