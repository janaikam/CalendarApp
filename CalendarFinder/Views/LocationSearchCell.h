//
//  LocationSearchCell.h
//  CalendarFinder
//
//  Created by Janai Kameka on 8/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchItems.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

-(void)updateWithSearchItem:(SearchItems *)searchItem;
@end

NS_ASSUME_NONNULL_END
