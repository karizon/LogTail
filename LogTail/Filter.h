//
//  Filter.h
//  LogTail
//
//  Created by Geoff Harrison on 7/20/14.
//  Copyright © 2014 Geoff Harrison <mandrake@mandrake.net>
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LogFile;

@interface Filter : NSManagedObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSNumber * filterType;
@property (nonatomic, retain) NSString * filterValue;
@property (nonatomic, retain) LogFile *logFile;

@end
