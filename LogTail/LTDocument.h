//
//  LTDocument.h
//  LogTail
//
//  Created by Geoff Harrison on 7/4/14.
//  Copyright © 2014 Geoff Harrison <mandrake@mandrake.net>
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

#import <Cocoa/Cocoa.h>

@class LTUnfilteredResult;
@class LTFilteredResult;

@interface LTDocument : NSPersistentDocument {
    IBOutlet NSWindow *configSheet;
    IBOutlet NSButton *detailButton;

    NSMutableArray *unfilteredList;
    NSMutableArray *filteredList;
    
    __weak NSTableView *_filteredView;
    __weak NSTableView *_unfilteredView;
}

@property (weak) IBOutlet NSTableView *unfilteredView;
@property (weak) IBOutlet NSTableView *filteredView;

@end
