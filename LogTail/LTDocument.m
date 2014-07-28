//
//  LTDocument.m
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

#import "LTDocument.h"
#import "LTUnfilteredResult.h"
#import "LTFilteredResult.h"
#import <NMSSH/NMSSH.h>

@interface LTDocument () <NMSSHChannelDelegate, NMSSHSessionDelegate>

@property (nonatomic, strong) dispatch_queue_t sshQueue;
@property (nonatomic, strong) NMSSHSession *session;
@property (nonatomic, assign) dispatch_once_t onceToken;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) NSMutableString *lastCommand;
@property (nonatomic, assign) BOOL keyboardInteractive;

// Filtered Table

@property (weak) IBOutlet NSTableView *unfilteredTableView;

@property (weak) IBOutlet NSButton *viewDetailsButton;
@property (weak) IBOutlet NSButton *adjustFilterButton;
@property (weak) IBOutlet NSButton *clearSelectedButton;

- (IBAction)viewDetails:(id)sender;
- (IBAction)adjustFilter:(id)sender;
- (IBAction)clearSelected:(id)sender;

// Unfiltered Table

@property (weak) IBOutlet NSTableView *filteredTableView;

@property (weak) IBOutlet NSButton *createNewFilterButton;
@property (weak) IBOutlet NSButton *purgeUnfilteredButton;

- (IBAction)createNewFilter:(id)sender;
- (IBAction)purgeUnfiltered:(id)sender;

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
    
    
    self.session = [NMSSHSession connectToHost:@"p3plananvar01" port:22 withUsername:@"root"];
    self.session.delegate = self;

    if(self.session.isConnected) {
        NSLog(@"LogTail: Connect succeeded");
        [self.session connectToAgent]; // This is win right here boys and girls.
        
        if(self.session.authorized) {
            NSLog(@"LogTail: Auth succeeded!");
            self.session.channel.delegate = self;
            self.session.channel.requestPty = YES;

            NSError *error;
            [self.session.channel startShell:&error];
            
            if (error) {
                NSLog(@"LogTail: Error starting shell: %@",error.localizedDescription);
            } else {
                NSLog(@"LogTail: Shell started.  issuing tail command");
                [[self.session channel] write:@"tail -f /var/log/haproxy/haproxy.log\n" error:nil timeout:@10];
            }
            
        } else {
            NSLog(@"LogTail: Agent based authentication has failed.  Would resort to password here normally");
        }
    }
    
}

#pragma mark Document

+ (BOOL)autosavesInPlace {
    return NO;
}

#pragma mark Config Sheet

- (IBAction)openConfigSheet:(id)sender {
    NSLog(@"Opening Config Sheet");
    [NSApp beginSheet:configSheet modalForWindow:[_viewDetailsButton window] modalDelegate:nil didEndSelector:NULL contextInfo:NULL];
}

- (IBAction)endConfigSheet:(id)sender {
    [NSApp endSheet:configSheet];
    // Time to spawn the threads.
    [configSheet orderOut:configSheet];
}


#pragma mark SSH Session

- (void)session:(NMSSHSession *)session didDisconnectWithError:(NSError *)error {
    NSLog(@"LogTail: Session Disconnected with Error: %@", error.localizedDescription);
}

- (void)channelShellDidClose:(NMSSHChannel *)channel {
    NSLog(@"LogTail: Remote Shell Closed");
}

- (void)channel:(NMSSHChannel *)channel didReadData:(NSString *)message {
    // NSLog(@"LogTail: Received data: %@", message);

    /*
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[ ]\\[(.+)\\][ ]"
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    [regex enumerateMatchesInString:message options:0 range:NSMakeRange(0, [message length]) usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        NSRange myRange = NSMakeRange(match.range.location + 2, match.range.length - 4);
        NSString *localMatch = [message substringWithRange:myRange];
        // NSLog(@"Found Date: %@",localMatch);
    }];
     */
    
}

- (void)channel:(NMSSHChannel *)channel didReadError:(NSString *)error {
    NSLog(@"LogTail: Read Error: %@", [NSString stringWithFormat:@"[ERROR] %@", error]);
}

- (NSString *)session:(NMSSHSession *)session keyboardInteractiveRequest:(NSString *)request {
    NSLog(@"LogTail: Request for interactive data: %@",request);
    return request;
}

#pragma mark tableView

- (NSInteger) numberOfRowsInTableView: (NSTableView *) tv {
    if(tv == _filteredTableView) {
        NSLog(@"Asked for number in filtered view");
        return [filteredList count];
    } else if (tv == _unfilteredTableView) {
        NSLog(@"Asked for number in unfiltered view");
        return [unfilteredList count];
    }
    
    return 0;
}

- (void) tableViewSelectionIsChanging:(NSNotification *) aNotification {
    
}

- (void) tableViewSelectionDidChange:(NSNotification *) aNotification {

}

- (void) tableView:(NSTableView *)tv sortDescriptorsDidChange: (NSArray *)oldDescriptors {
}

- (id) tableView: (NSTableView *) tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if(tv == _unfilteredView) {
        if(row < [unfilteredList count]) {
        }
    }
    
    return nil;
    
}

- (void) tableView: (NSTableView *) tv willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)col row:(int)row {
}

- (IBAction)createNewFilter:(id)sender {
    NSLog(@"LogTail: Creating new filter");
}

- (IBAction)purgeUnfiltered:(id)sender {
    NSLog(@"Purging unfiltered data");
}

- (IBAction)viewDetails:(id)sender {
    NSLog(@"Viewing Details");
}

- (IBAction)adjustFilter:(id)sender {
    NSLog(@"Editing Filter");
}

- (IBAction)clearSelected:(id)sender {
    NSLog(@"Clearing selected");
}
@end
