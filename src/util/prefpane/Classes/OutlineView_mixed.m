// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-

#import "OutlineView_mixed.h"

@implementation org_pqrs_PCKeyboardHack_OutlineView_mixed

- (id) init
{
  self = [super init];

  if (self) {
    [self loadXML:@"/Library/org.pqrs/PCKeyboardHack/prefpane/checkbox.xml"];
  }

  return self;
}

- (void) initialExpandCollapseTree
{
  for (NSDictionary* dict in datasource_) {
    if ([[dict objectForKey:@"expand"] isEqualToString:@"true"]) {
      [outlineview_ expandItem:dict];
    } else {
      [outlineview_ collapseItem:dict];
    }
  }
}

// ------------------------------------------------------------
- (id) outlineView:(NSOutlineView*)outlineView objectValueForTableColumn:(NSTableColumn*)tableColumn byItem:(id)item
{
  NSString* identifier = [tableColumn identifier];

  if ([identifier isEqualToString:@"enable"]) {
    NSButtonCell* cell = [tableColumn dataCell];
    if (! cell) return nil;

    NSString* name = [item objectForKey:@"name"];
    if (! name) return nil;

    [cell setTitle:name];

    NSString* enable = [item objectForKey:@"enable"];
    if (! enable) {
      [cell setImagePosition:NSNoImage];
      return nil;

    } else {
      [cell setImagePosition:NSImageLeft];

      return [NSNumber numberWithInt:[[client_ proxy] value:enable]];
    }

  } else if ([identifier isEqualToString:@"keycode"]) {
    NSString* keycode = [item objectForKey:@"keycode"];
    if (! keycode) return nil;

    return [NSNumber numberWithInt:[[client_ proxy] value:keycode]];

  } else if ([identifier isEqualToString:@"default"]) {
    NSString* keycode = [item objectForKey:@"keycode"];
    if (! keycode) return nil;

    int keycodevalue = [[client_ proxy] defaultValue:keycode];
    NSString* keycodename = [outlineview_keycode_ getKeyName:keycodevalue];

    return [NSString stringWithFormat:@"%d (%@)", keycodevalue, keycodename];
  }

  return nil;
}

- (void) outlineView:(NSOutlineView*)outlineView setObjectValue:(id)object forTableColumn:(NSTableColumn*)tableColumn byItem:(id)item
{
  NSString* identifier = [tableColumn identifier];

  if ([identifier isEqualToString:@"enable"]) {
    NSString* enable = [item objectForKey:@"enable"];
    if (enable) {
      int value = [[client_ proxy] value:enable];
      value = ! value;
      [[client_ proxy] setValueForName:value forName:enable];
    } else {
      // expand/collapse tree
      if ([outlineView isExpandable:item]) {
        if ([outlineView isItemExpanded:item]) {
          [outlineView collapseItem:item];
        } else {
          [outlineView expandItem:item];
        }
      }
    }

  } else if ([identifier isEqualToString:@"keycode"]) {
    NSString* keycode = [item objectForKey:@"keycode"];
    if (keycode) {
      [[client_ proxy] setValueForName:[object intValue] forName:keycode];
    }
  }
}

- (CGFloat) outlineView:(NSOutlineView*)outlineView heightOfRowByItem:(id)item
{
  CGFloat height = [outlineView rowHeight];

  NSNumber* number = [item objectForKey:@"height"];
  if (number) {
    CGFloat newheight = [outlineView rowHeight] * [number intValue];
    if (newheight > height) {
      height = newheight;
    }
  }

  return height;
}

@end
