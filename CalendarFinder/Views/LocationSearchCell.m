//
//  LocationSearchCell.m
//  CalendarFinder
//
//  Created by Janai Kameka on 8/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import "LocationSearchCell.h"

@implementation LocationSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateWithSearchItem:(SearchItems *)searchItem{
    self.addressLabel.text = [NSString stringWithFormat:@"%@",[searchItem placemark]];
    self.locationLabel.text = [searchItem name];
}

@end
