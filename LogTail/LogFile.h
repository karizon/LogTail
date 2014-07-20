//
//  LogFile.h
//  LogTail
//
//  Created by Geoff Harrison on 7/20/14.
//  Copyright © 2014 Geoff Harrison <mandrake@mandrake.net>
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Filter;

@interface LogFile : NSManagedObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) NSString * host;
@property (nonatomic, retain) Filter *filters;

@end
