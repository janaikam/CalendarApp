//
//  LoginViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "LoginViewController.h"
@import Parse;

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UIButton *backToLoginButton;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *signUpLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.signUpButton.alpha = 0;
    self.confirmPasswordField.alpha = 0;
    self.backToLoginButton.alpha = 0;
    self.signUpLabel.alpha = 0;
    self.createButton.layer.cornerRadius = 10.0;
    self.backToLoginButton.layer.cornerRadius = 10.0;

}

- (IBAction)didTapSignUp:(id)sender {
    
    if (![self.passwordField.text isEqualToString:self.confirmPasswordField.text]) {
        [self createUICancelAlert:@"Passwords don't match!" withAlertMessage:@"Please make sure that your password is the same in both fields."];
        return;
    }
    
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        NSLog(@"There is no username or password");
        NSString *message = @"Username/Password is empty. Please enter a value in the field.";
        [self createUICancelAlert:@"Blank Username/Password" withAlertMessage:message];
        return;
    }
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
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
    
}

- (IBAction)didTapLogIn:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        NSLog(@"Empty Username or Password");
        NSString *message = @"Username/Password is empty. Please enter a value in the field.";
        [self createUICancelAlert:@"Blank Username/Password" withAlertMessage:message];
        return;
    }
    
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
}

-(void)createUICancelAlert:(NSString *)alertName withAlertMessage:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertName message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

- (IBAction)didTapCreateNew:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.loginButton.alpha = 0;
        self.createButton.alpha = 0;
        self.loginLabel.alpha = 0;
        self.confirmPasswordField.alpha = 1;
        self.signUpButton.alpha = 1;
        self.backToLoginButton.alpha = 1;
        self.signUpLabel.alpha = 1;
    }];
    
}

- (IBAction)didTapBack:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.confirmPasswordField.alpha = 0;
        self.signUpButton.alpha = 0;
        self.backToLoginButton.alpha = 0;
        self.signUpLabel.alpha = 0;
        self.loginButton.alpha = 1;
        self.createButton.alpha = 1;
        self.loginLabel.alpha = 1;
    }];
    
}

- (IBAction)didTapContinueFacebook:(id)sender {
    [PFFacebookUtils logInInBackgroundWithReadPermissions:nil block:^(PFUser *user, NSError *error) {
        if (!error && user){
            [self dismissViewControllerAnimated:YES completion:^{
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            }];
            
        } else if (error){
            NSLog(@"User log in failed: %@", error.localizedDescription);
            NSString *errorMessage = [@"Error: " stringByAppendingFormat:@"%@", error.localizedDescription];
            NSLog(@"%@", errorMessage);
            [self createUICancelAlert:@"Error" withAlertMessage:errorMessage];
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
