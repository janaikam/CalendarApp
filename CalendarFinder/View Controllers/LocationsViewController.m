//
//  LocationsViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/15/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "LocationsViewController.h"
#import "LocationCell.h"
#import "CreateEventViewController.h"
#import "SearchItems.h"
#import <MapKit/MapKit.h>

static NSString * const clientID = @"UVKZOMUZQJTQWA5UYH5LDOQ5UPL0GNDXBUEMVHQJNDPYENV3";
static NSString * const clientSecret = @"4ABXB0QRBIQBEG4WX5JAU4PK2AF1CVVP30LD13UIJS3EUV3V";

@interface LocationsViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<SearchItems *> *results;

@end

@implementation LocationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    self.results = [[NSMutableArray alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // This is the selected venue
    SearchItems *venueObject = self.results[indexPath.row];
    
    NSNumber *lat = [venueObject latitude];
    NSNumber *lng = [venueObject longitude];
    NSString *name = [venueObject name];
    
    [self.delegate locationsViewController:self didPickLocationWithLatitude:lat longitude:lng name:name];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    SearchItems *venue = self.results[indexPath.row];
    [cell updateWithVenue:venue];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    
    // Change later to user's current location
    [self.results removeObjectsInArray:self.results];
    [self fetchLocationsWithQuery:newText];
    return true;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.results removeObjectsInArray:self.results];
    [self fetchLocationsWithQuery:searchBar.text];
}

- (void)fetchLocationsWithQuery:(NSString *)query {
     MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
       [searchRequest setNaturalLanguageQuery:query];
       
       MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
       [localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
           if (!error) {
               for (MKMapItem *mapItem in [response mapItems]) {
                   SearchItems *newItem = [[SearchItems alloc] initWithMKMapItem:mapItem];
                   [self.results addObject:newItem];
               }
               [self.tableView reloadData];
           } else {
               NSLog(@"Search Request Error: %@", [error localizedDescription]);
           }
       }];
    
}




@end
