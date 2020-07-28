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
@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation EventFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //get user's location when the screen loads
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager startUpdatingLocation];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Change to users' current location
//    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
//    [self.mapView setRegion:sfRegion animated:false];
    
    [self getFeed];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.locationManager stopUpdatingLocation];

    MKCoordinateRegion currentLocation = MKCoordinateRegionMake(self.locationManager.location.coordinate, MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:currentLocation];

}

// Gets the events from Parse
-(void)getFeed{
    NSDate *today = [NSDate date];
    PFQuery *query = [Event query];
    [query includeKey:@"author"];
    //loads events that haven't ended/past yet
    [query whereKey:@"endTime" greaterThan:today];
    //orders events by time
    [query orderByAscending:@"startTime"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray<Event *> * _Nullable objects, NSError * _Nullable error) {
        if (objects) {
            NSLog(@"Succesfully Loaded Feed!");
            self.eventArray = [objects mutableCopy];
            
            for (Event *event in objects) {
                PFRelation *relation = [event relationForKey:@"locationRelation"];
                PFQuery *relationQuery = [relation query];
                [relationQuery findObjectsInBackgroundWithBlock:^(NSArray<Location *> * _Nullable locations, NSError * _Nullable error) {
                    Location *eventLocation = locations[0];
                    [self addPin:eventLocation];
                }];
            }
            
            [self.tableView reloadData];
        } else{
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

//Takes in a Location and adds a pin to the map
-(void)addPin:(Location *)location{
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(location.latitude.floatValue, location.longitude.floatValue);
    
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coordinate;
    annotation.title = @"Event!";
    [self.mapView addAnnotation:annotation];
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
