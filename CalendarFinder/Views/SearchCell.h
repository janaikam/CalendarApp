//
//  SearchCell.h
//  CalendarFinder
//
//  Created by Janai Kameka on 8/7/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface SearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLocationLabel;
@property (strong, nonatomic) Event *event;

-(void)setEvent:(Event *) event;
@end

NS_ASSUME_NONNULL_END
