/*****************************************************************
 M3ColumnVisibilityController.h
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 When hooked up to a table view, this class will create a contextual menu on the header to allow users to 
 show and hide columns
 @since M3AppKit 1.0 and later
 */
@interface M3ColumnVisibilityController : NSObject <NSCoding>

/**
 An array of column identifiers that should not be included in the menu
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (copy, nonatomic) NSArray *ignoredColumnIdentifiers;

/**
 The table view to handle column visibility for
 @since M3AppKit 1.0 and later
 */
@property (nonatomic, strong) IBOutlet NSTableView *tableView;


/**
 The menu for showing and hiding columns for the table
 @result The menu instance for the table
 @since M3AppKit 1.0 and later
 */
@property (readonly) NSMenu *menu;

@end
