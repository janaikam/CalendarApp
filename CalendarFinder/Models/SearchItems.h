//
//  SearchItems.h
//  CalendarFinder
//
//  Created by Janai Kameka on 8/13/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchItems : NSObject

@property (nonatomic, strong) MKMapItem *mapItem;

@property(nonatomic, strong, readonly) NSNumber *latitude;
@property(nonatomic, strong, readonly) NSNumber *longitude;
@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) MKPlacemark *placemark;

-(instancetype)initWithMKMapItem: (MKMapItem *)mapItem;
@end

NS_ASSUME_NONNULL_END
