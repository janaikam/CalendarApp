//
//  CreateEventViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "CreateEventViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "EventFeedViewController.h"
#import "LocationsViewController.h"


@interface CreateEventViewController () <LocationsViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITextField *eventDescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePickerView;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePickerView;
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;



@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.startDatePickerView.alpha = 0;
    self.endDatePickerView.alpha = 0;
    
}

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude name:(NSString *) name{
    NSLog(@"%@", name);
    self.locationNameLabel.text = name;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
};


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)onTapPicture:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
//    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    // Resizing for Parse
    [self resizeImage:editedImage withSize:CGSizeMake(960, 1440)];
    self.eventImageView.image = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapStartTime:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.startDatePickerView.alpha = 1;
        self.endDatePickerView.alpha = 0;
        
        self.endLabel.alpha = 0;
        self.endTimeLabel.alpha = 0;
        self.locationButton.alpha = 0;
        self.locationNameLabel.alpha = 0;
    }];
}

- (IBAction)onTapScreen:(id)sender {
    [UIView  animateWithDuration:0.2 animations:^{
        self.startDatePickerView.alpha = 0;
        self.endDatePickerView.alpha = 0;
        
        self.endLabel.alpha = 1;
        self.endTimeLabel.alpha = 1;
        self.locationButton.alpha = 1;
        self.locationNameLabel.alpha = 1;

    }];
    [self.view endEditing:YES];

}

- (IBAction)onTapEndTime:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.endDatePickerView.alpha = 1;
        self.startDatePickerView.alpha = 0;
        self.locationButton.alpha = 0;
        self.locationNameLabel.alpha = 0;
    }];

}

- (IBAction)startValueChanged:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;

    
    self.startTimeLabel.text = [formatter stringFromDate:self.startDatePickerView.date];
    
}

- (IBAction)endValueChanged:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm";
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    self.endTimeLabel.text = [formatter stringFromDate:self.endDatePickerView.date];
}

- (IBAction)didTapCancel:(id)sender {
    SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventFeedViewController *eventViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
    myDelegate.window.rootViewController = eventViewController;
}

- (IBAction)didTapLocation:(id)sender {
    [self performSegueWithIdentifier:@"locationSegue" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"locationSegue"]){
        LocationsViewController *locations = [segue destinationViewController];
        locations.delegate = self;
    }
}


@end
