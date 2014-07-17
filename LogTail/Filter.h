//
//  Filter.h
//  LogTail
//
//  Created by Geoff Harrison on 7/17/14.
//  Copyright (c) 2014 Mandrake.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LogFile;

@interface Filter : NSManagedObject

@property (nonatomic, retain) NSNumber * filterType;
@property (nonatomic, retain) NSString * filterValue;
@property (nonatomic, retain) LogFile *logFile;

@end
