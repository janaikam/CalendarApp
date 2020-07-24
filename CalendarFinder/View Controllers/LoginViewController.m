//
//  LoginViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapSignUp:(id)sender {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    if (![self.usernameField.text isEqualToString:@""] || ![self.passwordField.text isEqualToString:@""]) {
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSString *errorMessage = [@"Error: " stringByAppendingFormat:@"%@", error.localizedDescription];
            NSLog(@"%@", errorMessage);
            [self createUICancelAlert:@"Error" withAlertMessage:errorMessage];
            
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    } else{
        NSLog(@"There is no username or password");
        NSString *message = @"Username/Password is empty. Please enter a value in the field.";
        [self createUICancelAlert:@"Blank Username/Password" withAlertMessage:message];
    }
}

- (IBAction)didTapLogIn:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if (![self.usernameField.text isEqualToString:@""] || ![self.passwordField.text isEqualToString:@""]) {
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            NSString *errorMessage = [@"Error: " stringByAppendingFormat:@"%@", error.localizedDescription];
            NSLog(@"%@", errorMessage);
            [self createUICancelAlert:@"Error" withAlertMessage:errorMessage];
            
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    } else{
        NSLog(@"Empty Username or Password");
        NSString *message = @"Username/Password is empty. Please enter a value in the field.";
        [self createUICancelAlert:@"Blank Username/Password" withAlertMessage:message];
    }
}

-(void)createUICancelAlert:(NSString *)alertName withAlertMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertName message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
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
