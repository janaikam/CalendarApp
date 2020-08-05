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
#import "DateHelper.h"
@import Parse;

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *attendeesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;


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
    self.locationNameLabel.text = self.event.location;
    
    self.eventImageView.file = self.event.image;
    [self.eventImageView loadInBackground];
    
    
    NSDateFormatter *formatter = [DateHelper dateFormat];
    self.startDateLabel.text = [formatter stringFromDate:self.event.startTime];
    self.endDateLabel.text = [formatter stringFromDate:self.event.endTime];
    
}

- (IBAction)didTapAddCalendar:(id)sender {
    [self addEventtoCalendar];
}

- (IBAction)didDoubleTapEvent:(id)sender {
    [self addEventtoCalendar];
}


-(void)addEventtoCalendar{
    [self.event connectEventAttendees:self.event user:[PFUser currentUser] withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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

- (IBAction)didTapShare:(id)sender {
    NSArray *objectsToShare;
    NSString *shareText = @"Check out this fun event! I think it sounds fun!";
    UIImage *shareImage = self.eventImageView.image;
    
    objectsToShare = @[shareText, shareImage];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo,
                                   UIActivityTypePostToWeibo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    [self presentViewController:activityVC animated:YES completion:nil];
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
