//
//  LogFile.h
//  LogTail
//
//  Created by Geoff Harrison on 7/17/14.
//  Copyright (c) 2014 Mandrake.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LogFile : NSManagedObject

@property (nonatomic, retain) NSString * host;
@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) NSManagedObject *filters;

@end
