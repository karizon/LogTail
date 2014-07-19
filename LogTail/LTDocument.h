//
//  LTDocument.h
//  LogTail
//
//  Created by Geoff Harrison on 7/4/14.
//  Copyright © 2014 Geoff Harrison <mandrake@mandrake.net>
//

#import <Cocoa/Cocoa.h>

@interface LTDocument : NSPersistentDocument {
    IBOutlet NSWindow *configSheet;
    IBOutlet NSButton *detailButton;

}

@end
