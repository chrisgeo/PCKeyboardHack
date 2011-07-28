// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-
#import <Cocoa/Cocoa.h>
#import "PCKeyboardHackClient.h"
#import "OutlineView.h"
#import "OutlineView_keycode.h"

@interface org_pqrs_PCKeyboardHack_OutlineView_mixed : org_pqrs_PCKeyboardHack_OutlineView
{
  IBOutlet org_pqrs_PCKeyboardHack_Client* client_;
  IBOutlet org_pqrs_PCKeyboardHack_OutlineView_keycode* outlineview_keycode_;
  IBOutlet id outlineview_;
}

- (void) initialExpandCollapseTree;

@end
