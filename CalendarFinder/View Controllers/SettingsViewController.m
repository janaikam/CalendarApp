//
//  SettingsViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/31/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "SettingsViewController.h"
#import "User.h"

@interface SettingsViewController ()


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Boolean darkBoolValue = [defaults doubleForKey:@"darkMode"];
    Boolean weekCalendarView = [defaults doubleForKey:@"weekMode"];
    
    [self.darkModeSwitch setOn:darkBoolValue];
    if (weekCalendarView) {
        [self.calendarSegmentControl setSelectedSegmentIndex:1];
    }
}


- (IBAction)didSwitchDarkMode:(id)sender {
    if (self.darkModeSwitch.on) {
        [NSNotificationCenter.defaultCenter postNotificationName:@"didSwitchDark" object:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"darkMode"];
        [defaults synchronize];
    } else{
        [NSNotificationCenter.defaultCenter postNotificationName:@"didSwitchLight" object:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"darkMode"];
        [defaults synchronize];
    }
}

- (IBAction)didChangeCalendarView:(id)sender {
    NSString *segment = [self.calendarSegmentControl titleForSegmentAtIndex:self.calendarSegmentControl.selectedSegmentIndex];
    
    if ([segment isEqualToString:@"Week"]) {
        [NSNotificationCenter.defaultCenter postNotificationName:@"didSwitchWeek" object:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"weekMode"];
        [defaults synchronize];
    } else{
        [NSNotificationCenter.defaultCenter postNotificationName:@"didSwitchMonth" object:nil];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:@"weekMode"];
        [defaults synchronize];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
