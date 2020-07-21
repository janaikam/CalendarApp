//
//  EventFeedViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "EventFeedViewController.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "LoginViewController.h"
#import "DetailsViewController.h"
#import "SceneDelegate.h"
#import "EventCell.h"
#import "Event.h"


@interface EventFeedViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *eventArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation EventFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Change to users' current location
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    
    [self getFeed];
}

-(void)getFeed{
    PFQuery *query = [Event query];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects) {
            NSLog(@"Succesfully Loaded Feed!");
            self.eventArray = [objects mutableCopy];
            
            [self.tableView reloadData];
        } else{
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error){
            NSLog(@"There was an error logging out.");
        } else {
         SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        myDelegate.window.rootViewController = loginViewController;
        }
    }];
}

- (IBAction)didTapCreate:(id)sender {
    [self performSegueWithIdentifier:@"createSegue" sender:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    Event *event = self.eventArray[indexPath.row];
    
    [cell setEvent:event];
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventArray.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Event *event = self.eventArray[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.event = event;
    }
}





@end
