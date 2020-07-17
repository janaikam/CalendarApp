//
//  CreateEventViewController.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateEventViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSNumber *lat;
@property NSNumber *lon;

@end

NS_ASSUME_NONNULL_END
