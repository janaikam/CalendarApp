//
//  CalendarViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "CalendarViewController.h"
#import "Event.h"
#import "CalendarCell.h"
#import <FSCalendar/FSCalendar.h>
#import <Parse/Parse.h>
#import "DetailsViewController.h"

@import DGActivityIndicatorView;

@interface CalendarViewController () <FSCalendarDataSource, FSCalendarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet FSCalendar *calendarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *calendarEventArray;
@property (weak, nonatomic) NSString *defaultCalendarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;
@property (weak, nonatomic) IBOutlet DGActivityIndicatorView *activityIndicatorView;


@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.activityIndicatorView.type = DGActivityIndicatorAnimationTypeCookieTerminator;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleWeekMode) name:@"didSwitchWeek" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toggleMonthMode) name:@"didSwitchMonth" object:nil];
    
    self.tableView.layer.cornerRadius = 5;
    
    self.activityIndicatorView.alpha = 0;
    
    self.calendarView.dataSource = self;
    self.calendarView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical;
    self.calendarEventArray = [[NSMutableArray alloc] init];
    
    [self loadTableView:self.tableView withDate:self.calendarView.today];
}

-(void)viewWillAppear:(BOOL)animated{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults doubleForKey:@"weekMode"]) {
        [self toggleWeekMode];
    } else{
        _calendarView.scope = FSCalendarScopeMonth;
    }
    
    self.calendarView.appearance.todayColor = [UIColor colorNamed:@"Today"];
    [self.view layoutIfNeeded];
}


// FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    [self loadTableView:self.tableView withDate:date];
}


- (void) loadTableView:(UITableView *) tableView withDate: (NSDate *)date{
    self.activityIndicatorView.alpha = 1;
    [self.activityIndicatorView startAnimating];
    
    [self.calendarEventArray removeAllObjects];
    
    NSDate *nextDay = [date dateByAddingTimeInterval:84600];
    
    PFQuery *query = [Event query];
    
    //Checks if the date is between the beginning of the given date
    //and the end of the next date
    [query whereKey:@"endTime" greaterThan:date];
    [query whereKey:@"startTime" lessThan:nextDay];
    
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Event *> * _Nullable objects, NSError * _Nullable error) {
        if (objects){
            //iterate through all the events loaded
            for (Event *event in objects) {
                PFRelation *relation = [event relationForKey:@"attendees"];
                PFQuery *relationQuery = [relation query];
                relationQuery.limit = 1;
                
                [relationQuery findObjectsInBackgroundWithBlock:^(NSArray<PFUser *> * _Nullable people, NSError * _Nullable error) {
                    if (people) {
                        //checks if the user accepted the calendar invitation
                        //only lets the event appear if the user added it
                        for (PFUser *user in people) {
                            
                            if ([user.objectId isEqual:[PFUser currentUser].objectId]){
                                [self.calendarEventArray addObject:event];
                                [self.tableView reloadData];
                                self.activityIndicatorView.alpha = 0;
                                [self.activityIndicatorView stopAnimating];
                                
                            }
                        }
                    }
                }];
                
            }
            NSLog(@"Calendar Feed loaded");
            
        }else if(error){
            NSLog(@"%@", error.localizedDescription);
        }else{
            NSLog(@"There are no events to display");
        }
        
    }];
    
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell"];
    Event *event = self.calendarEventArray[indexPath.row];
    
    [cell setEvent:event];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.calendarEventArray.count;
}

-(void)toggleWeekMode{
    _calendarView.scope = FSCalendarScopeWeek;
    self.calendarHeightConstraint.constant = 138;
}

-(void)toggleMonthMode{
    _calendarView.scope = FSCalendarScopeMonth;
    self.calendarHeightConstraint.constant = 408;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Event *event = self.calendarEventArray[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.event = event;
    }
}


@end
