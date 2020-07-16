//
//  LocationCell.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/15/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

NS_ASSUME_NONNULL_END
