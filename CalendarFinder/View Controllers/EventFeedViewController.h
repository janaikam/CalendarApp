//
//  EventFeedViewController.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventFeedViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@end

NS_ASSUME_NONNULL_END
