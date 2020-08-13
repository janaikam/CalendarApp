//
//  LocationSearchViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 8/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "LocationSearchViewController.h"
#import "EventFeedViewController.h"
#import "LocationSearchCell.h"
#import <MapKit/MapKit.h>
#import "SearchItems.h"

@interface LocationSearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray<SearchItems *> *locationArray;

@end

@implementation LocationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    
    self.locationArray = [NSMutableArray new];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if ([searchBar.text isEqualToString:@""]) {
        [self.locationArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    [self searchForLocationWithName:searchBar.text];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([searchBar.text isEqualToString:@""]) {
        [self.locationArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    [self searchForLocationWithName:searchText];
}

-(void)searchForLocationWithName: (NSString *)locationName{
    [self.locationArray removeAllObjects];
    
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] init];
    [searchRequest setNaturalLanguageQuery:locationName];
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            for (MKMapItem *mapItem in [response mapItems]) {
                SearchItems *newItem = [[SearchItems alloc] initWithMKMapItem:mapItem];
                [self.locationArray addObject:newItem];
            }
            [self.tableView reloadData];
        } else {
            NSLog(@"Search Request Error: %@", [error localizedDescription]);
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LocationSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationSearchCell"];
    SearchItems *searchItem = self.locationArray[indexPath.row];
    [cell updateWithSearchItem:searchItem];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.locationArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchItems *item = self.locationArray[indexPath.row];
    NSNumber *lat = [item latitude];
    NSNumber *lon = [item longitude];
    
    [self.delegate locationSearchViewController:self didPickLocationWithLatitude:lat longitude:lon];
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
