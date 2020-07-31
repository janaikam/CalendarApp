//
//  SettingsViewController.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/31/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SettingsViewController;
@protocol SettingsViewControllerDelegate

-(void)settingsViewController: (SettingsViewController *)controller didPickTypeCalendar: (NSString *)type;

@end

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) id<SettingsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
