/*****************************************************************
M3ColumnVisibilityController.h
M3Extensions

Created by Martin Pilkington on 18/02/2010.

Copyright (c) 2006-2010 M Cubed Software

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

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
