/*****************************************************************
 M3ColumnVisibilityControllerExampleWindowController.h
 M3AppKit
 
 Created by Martin Pilkington on 12/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>
#import <M3AppKit/M3AppKit.h>

@interface M3ColumnVisibilityControllerExampleWindowController : NSWindowController

@property (weak) IBOutlet NSSegmentedControl *ignoredColumns;
@property (strong) IBOutlet M3ColumnVisibilityController *columnVisibilityController;

- (IBAction)updateIgnored:(id)sender;

@end
