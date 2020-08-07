//
//  SearchCell.m
//  CalendarFinder
//
//  Created by Janai Kameka on 8/7/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "SearchCell.h"
#import "DateHelper.h"

@implementation SearchCell

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
    self.eventImage.file = event[@"image"];
    [self.eventImage loadInBackground];
    
    self.eventNameLabel.text = event.eventName;
    self.eventDescriptionLabel.text = event.eventDescription;
    self.eventLocationLabel.text = event.location;
    
    NSDateFormatter *formatter = [DateHelper dateFormatHourSeconds];
    self.eventTimeLabel.text = [formatter stringFromDate:event.startTime];
}

@end
