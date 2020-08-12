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
@protocol EventCellDelegate;

@interface EventCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *eventView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) id <EventCellDelegate> delegate;

@property (strong, nonatomic) Event *event;

@end

@protocol EventCellDelegate

-(void)eventCell: (EventCell *)eventCell didTapEvent: (Event *)event;

@end

NS_ASSUME_NONNULL_END
