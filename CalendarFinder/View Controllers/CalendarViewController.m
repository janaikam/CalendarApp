//
//  CalendarViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "CalendarViewController.h"
#import <FSCalendar/FSCalendar.h>

@interface CalendarViewController () <FSCalendarDataSource, FSCalendarDelegate>
@property (weak, nonatomic) FSCalendar *calendar;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    FSCalendar *calendar = [[FSCalendar alloc] init];
    calendar.dataSource = self;
    calendar.delegate = self;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    self.calendar.scrollDirection = FSCalendarScrollDirectionVertical;
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
