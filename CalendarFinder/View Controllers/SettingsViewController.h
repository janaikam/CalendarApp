//
//  SettingsViewController.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/31/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISegmentedControl *calendarSegmentControl;
@property (weak, nonatomic) IBOutlet UISwitch *darkModeSwitch;

@end

NS_ASSUME_NONNULL_END
