//
//  LTAppDelegate.m
//  LogTail
//
//  Created by Geoff Harrison on 7/21/14.
//  Copyright (c) 2014 Mandrake.net. All rights reserved.
//

#import "LTAppDelegate.h"

@implementation LTAppDelegate


- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender {
    NSURL *lastURL=[[[NSDocumentController sharedDocumentController] recentDocumentURLs] objectAtIndex:0];
    if (lastURL!=nil)
    {
        [[NSDocumentController sharedDocumentController] openDocumentWithContentsOfURL:lastURL display:YES error:nil];
        return NO;
    }
    
    return YES;
}

@end
