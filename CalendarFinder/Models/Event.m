//
//  Event.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "Event.h"

@interface Event()

@property (nonatomic, copy, readwrite) NSString *eventID;
@property (nonatomic, copy, readwrite) NSString *userID;
@property (nonatomic, strong ,readwrite) PFUser *author;

@end

@implementation Event

@dynamic eventName;
@dynamic eventID;
@dynamic userID;
@dynamic author;
@dynamic eventDescription;
@dynamic attendeesCount;
@dynamic startTime;
@dynamic endTime;
@dynamic image;
@dynamic location;

- (instancetype) initWithImage:(UIImage *)image
                 eventName:(NSString *)eventName
               description:(NSString *)eventDescription
                 startTime:(NSDate *)startTime
                   endTime:(NSDate *)endTime
                  location:(NSString *)location
        completion:(PFBooleanResultBlock)completion{
    if (self = [super init]){
        
        self.eventName = eventName;
        self.author = [PFUser currentUser];
        self.image = [self.class getPFFileFromImage:image];
        self.eventDescription = eventDescription;
        self.startTime = startTime;
        self.endTime = endTime;
        self.location = location;
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
    [locationQuery whereKey:@"location" equalTo:locationName];
    locationQuery.limit = 1;
    
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error){
            Location *location = objects[0];
            PFRelation *relation = [location relationForKey:@"locationRelation"];
            [relation addObject:event];
            [location saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded){
                    [event saveInBackgroundWithBlock:completion];
                    NSLog(@"Event success!");
                } else{
                    NSString *errorMessage = [@"Error: " stringByAppendingFormat:@"%@", error.localizedDescription];
                    NSLog(@"%@", errorMessage);
                }
            }];
            
        } else{
            NSString *errorMessage = [@"Error: " stringByAppendingFormat:@"%@", error.localizedDescription];
            NSLog(@"%@", errorMessage);
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
