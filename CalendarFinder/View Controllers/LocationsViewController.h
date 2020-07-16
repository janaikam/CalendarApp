//
//  LocationsViewController.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/15/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LocationsViewController;
@protocol LocationsViewControllerDelegate

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude name:(NSString *)name;

@end

@interface LocationsViewController : UIViewController

@property (weak, nonatomic) id<LocationsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
