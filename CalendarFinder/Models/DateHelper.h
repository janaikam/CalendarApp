//
//  DateHelper.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/24/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Creates date formatters for the dates on events
@interface DateHelper : NSObject

+(NSDateFormatter *)dateFormat;
+(NSDateFormatter *)dateFormatWithDayMonthYear;

@end

NS_ASSUME_NONNULL_END
