//
//  User.h
//  CalendarFinder
//
//  Created by Janai Kameka on 7/15/20.
//  Copyright © 2020 Janai Kameka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFObject <PFSubclassing>

@property (nonatomic, copy) NSString *username;

- (instancetype) initWithString: (NSString * _Nullable)userName
                     completion:(PFBooleanResultBlock _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
