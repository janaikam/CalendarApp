//
//  CreateEventViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "CreateEventViewController.h"
#import <Parse/Parse.h>

@interface CreateEventViewController () 
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UITextField *eventNameField;
@property (weak, nonatomic) IBOutlet UITextField *eventDescriptionField;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePickerView;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePickerView;



@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startDatePickerView.alpha = 0;
    self.endDatePickerView.alpha = 0;
    
    // Setting up the frames for the end time when inputting a date in start date
    self.endLabel.frame = CGRectMake(self.endLabel.frame.origin.x, self.endLabel.frame.origin.y, self.endLabel.frame.size.width, self.endLabel.frame.size.height);
    
    self.endTimeLabel.frame = CGRectMake(self.endTimeLabel.frame.origin.x, self.endTimeLabel.frame.origin.y, self.endTimeLabel.frame.size.width, self.endTimeLabel.frame.size.height);
}

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
    self.startDatePickerView.alpha = 1;
    
    CGRect newFrame = self.endLabel.frame;
    newFrame.origin.y += 216;
    self.endLabel.frame = newFrame;
    
    newFrame = self.endTimeLabel.frame;
    newFrame.origin.y += 216;
    self.endTimeLabel.frame = newFrame;
    
}

- (IBAction)onTapScreen:(id)sender {
    self.startDatePickerView.alpha = 0;
    self.endDatePickerView.alpha = 0;
    
    CGRect newFrame = self.endLabel.frame;
    newFrame.origin.y -= 216;
    self.endLabel.frame = newFrame;
    
    newFrame = self.endTimeLabel.frame;
    newFrame.origin.y -= 216;
    self.endTimeLabel.frame = newFrame;
}

- (IBAction)onTapEndTime:(id)sender {
    self.endDatePickerView.alpha = 1;
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
