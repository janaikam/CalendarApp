//
//  SettingsViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/31/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *calendarSegmentControl;
@property (weak, nonatomic) IBOutlet UISwitch *darkModeSwitch;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    if (self.calendarViewController.calendarScope){
        if ([self.calendarViewController.calendarScope isEqualToString:@"Week"]) {
            self.calendarSegmentControl.selectedSegmentIndex = 1;
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    NSString *segment = [self.calendarSegmentControl titleForSegmentAtIndex:self.calendarSegmentControl.selectedSegmentIndex];
    self.calendarViewController.calendarScope = segment;
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
