//
//  EventCell.m
//  CalendarFinder
//
//  Created by Janai Kameka on 7/14/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "EventCell.h"
#import "DateHelper.h"

@implementation EventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(goToEdit:)];
    [self addGestureRecognizer:longPress];
    [self setUserInteractionEnabled:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEvent:(Event *)event{
    _event = event;
    self.eventView.file = event[@"image"];
    [self.eventView loadInBackground];
    
    self.nameLabel.text = event.eventName;
    self.descriptionLabel.text = event.eventDescription;
    self.locationLabel.text = event.location;
    
    NSDateFormatter *formatter = [DateHelper dateFormatWithDayMonthYear];
    self.timeLabel.text = [formatter stringFromDate:event.startTime];
}

-(void)goToEdit: (UILongPressGestureRecognizer *)sender{
    [self.delegate eventCell:self didTapEvent:self.event];
}
@end
