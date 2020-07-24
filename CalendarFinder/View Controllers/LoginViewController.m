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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:errorMessage
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create a cancel action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                // handle cancel response here. Doing nothing will dismiss the view.
            }];
            
            // add the cancel action to the alertController
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:^{}];
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    } else{
        NSLog(@"There is no username or password");
        NSString *message = @"Username/Password is empty. Please enter a value in the field.";
        UIAlertController *signupAlert = [UIAlertController alertControllerWithTitle:@"Blank Username/Password"  message:message preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [signupAlert addAction:clearAction];
        [self presentViewController:signupAlert animated:YES completion:^{}];
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
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:errorMessage
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create a cancel action
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                // handle cancel response here. Doing nothing will dismiss the view.
            }];
            
            // add the cancel action to the alertController
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:^{}];
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    } else{
        NSLog(@"Empty Username or Password");
        NSString *message = @"Username/Password is empty. Please enter a value in the field.";
        UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Blank Username/Password"  message:message preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [loginAlert addAction:clearAction];
        [self presentViewController:loginAlert animated:YES completion:^{}];
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
