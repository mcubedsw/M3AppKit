/*****************************************************************
 M3ColumnVisibilityController.h
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 @class M3ColumnVisibilityController
 When hooked up to a table view, this class will create a contextual menu on the header to allow users to 
 show and hide columns
 @since Available in M3AppKit 1.0 and later
 */
@interface M3ColumnVisibilityController : NSObject <NSCoding> {
	NSTableView *tableView;
	NSMenu *menu;
	NSArray *ignoredColumnIdentifiers;
}


@property (copy) NSArray *ignoredColumnIdentifiers;

/**
 @property tableView
 The table view to handle column visibility for
 @since Available in M3AppKit 1.0 and later
 */
@property (nonatomic, retain) IBOutlet NSTableView *tableView;


/**
 The menu for showing and hiding columns for the table
 @result The menu instance for the table
 @since Available in M3AppKit 1.0 and later
 */
- (NSMenu *)menu;

@end
