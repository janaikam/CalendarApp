//
//  CalendarCell.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/23/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "CalendarCell.h"
#import "DateHelper.h"

@implementation CalendarCell

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
    
    self.eventNameLabel.text = event.eventName;
    self.descriptionLabel.text = event.eventDescription;
    self.locationLabel.text = event.location;
    
    NSDateFormatter *formatter = [DateHelper dateFormatHourSeconds];
    self.timeLabel.text = [formatter stringFromDate:event.startTime];
}

@end
