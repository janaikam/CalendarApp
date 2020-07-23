//
//  DetailsViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "DetailsViewController.h"
#import "SceneDelegate.h"
#import "CalendarViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *attendeesCountLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.event.eventName);
    
    // Load information from the previous screen.
    self.eventNameLabel.text = self.event.eventName;
    self.descriptionLabel.text = self.event.eventDescription;
    self.authorLabel.text = self.event.author.username;
    self.attendeesCountLabel.text = [NSString stringWithFormat:@"%d", self.event.attendeesCount.intValue];
    
    self.eventImageView.file = self.event.image;
    [self.eventImageView loadInBackground];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm";
    formatter.dateStyle = NSDateFormatterShortStyle;
    self.startDateLabel.text = [formatter stringFromDate:self.event.startTime];
    self.endDateLabel.text = [formatter stringFromDate:self.event.endTime];
    
}

- (IBAction)didTapAddCalendar:(id)sender {
    [self.event.attendees addObject:[PFUser currentUser]];
    int original = self.event.attendeesCount.intValue;
    original += 1;
    self.event.attendeesCount = [NSNumber numberWithInt:original];
    
    [self.event saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error){
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CalendarViewController *calendarViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
            myDelegate.window.rootViewController = calendarViewController;
        } else{
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    
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
