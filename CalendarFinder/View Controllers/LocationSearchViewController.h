//
//  LocationSearchViewController.h
//  CalendarFinder
//
//  Created by Janai Kameka on 8/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LocationSearchViewController;
@protocol LocationSearchViewControllerDelegate

- (void)locationSearchViewController:(LocationSearchViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

@end

@interface LocationSearchViewController : UIViewController
@property (weak, nonatomic) id<LocationSearchViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
