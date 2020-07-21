//
//  EventCell.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEvent:(Event *)event{
    _event = event;
    self.eventView.file = event[@"image"];
    [self.eventView loadInBackground];
    
    self.nameLabel.text = event[@"eventName"];
    self.descriptionLabel.text = event[@"eventDescription"];
    
    NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
    formatter.dateFormat = @"E MMM d HH:mm";
    formatter.dateStyle = NSDateFormatterShortStyle;
    self.timeLabel.text = [formatter stringFromDate:event[@"startTime"]];
}

@end
