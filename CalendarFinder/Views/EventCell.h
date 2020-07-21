//
//  EventCell.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *eventView;


@property (strong, nonatomic) Event *event;

@end

NS_ASSUME_NONNULL_END
