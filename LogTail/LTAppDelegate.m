//
//  LTAppDelegate.m
//  LogTail
//
//  Created by Geoff Harrison on 7/21/14.
//  Copyright (c) 2014 Mandrake.net. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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
