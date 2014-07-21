//
//  LogFile.h
//  LogTail
//
//  Created by Geoff Harrison on 7/21/14.
//  Copyright (c) 2014 Mandrake.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Filter;

@interface LogFile : NSManagedObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) NSString * host;
@property (nonatomic, retain) NSSet *filters;
@end

@interface LogFile (CoreDataGeneratedAccessors)

- (void)addFiltersObject:(Filter *)value;
- (void)removeFiltersObject:(Filter *)value;
- (void)addFilters:(NSSet *)values;
- (void)removeFilters:(NSSet *)values;

@end
