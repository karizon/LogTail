//
//  LTDocument.m
//  LogTail
//
//  Created by Geoff Harrison on 7/4/14.
//  Copyright © 2014 Geoff Harrison <mandrake@mandrake.net>
//

#import "LTDocument.h"
#import <NMSSH/NMSSH.h>

@interface LTDocument () <NMSSHChannelDelegate, NMSSHSessionDelegate>

@property (nonatomic, strong) dispatch_queue_t sshQueue;
@property (nonatomic, strong) NMSSHSession *session;
@property (nonatomic, assign) dispatch_once_t onceToken;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) NSMutableString *lastCommand;
@property (nonatomic, assign) BOOL keyboardInteractive;


@end

@implementation LTDocument

- (id)init {
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"LTDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    NMSSHSession *session = [NMSSHSession connectToHost:@"p3plananvar01" port:22 withUsername:@"root"];
    
    if(session.isConnected) {
        NSLog(@"Connect succeeded");
        [session connectToAgent]; // This is win right here boys and girls.
        
        if(session.authorized) {
            NSLog(@"Auth succeeded!");
        } else {
            NSLog(@"Agent based authentication has failed.  Would resort to password here normally");
        }
    }
    
}

+ (BOOL)autosavesInPlace {
    return YES;
}

@end
