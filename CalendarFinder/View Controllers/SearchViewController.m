//
//  SearchViewController.m
//  CalendarFinder
//
//  Created by Janai Kameka on 8/7/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailsViewController.h"
#import "Event.h"
#import "SearchCell.h"
@import Parse;

@interface SearchViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) NSArray <Event *> *tableViewArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    self.searchBar.delegate = self;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self getEventFromEventSearchWithString:searchBar.text];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSString *newText = [searchBar.text stringByReplacingCharactersInRange:range withString:text];
    [self getEventFromEventSearchWithString:newText];
    return true;
}

-(void)getEventFromEventSearchWithString: (NSString *)searchQuery{
    NSDate *today = [NSDate date];
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"eventName" containsString:searchQuery];
    [query whereKey:@"endTime" greaterThan:today];
    [query orderByAscending:@"startTime"];
    [query includeKey:@"author"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            self.tableViewArray = [objects mutableCopy];
            [self.searchTableView reloadData];
        } else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"searchSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.searchTableView indexPathForCell:tappedCell];
        Event *event = self.tableViewArray[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        detailsViewController.event = event;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell"];
    Event *event = self.tableViewArray[indexPath.row];
    [cell setEvent:event];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewArray.count;
}



@end
