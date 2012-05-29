/*****************************************************************
 NSTabView+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 20/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 This category adds some convienience methods to NSTabView
 @since M3AppKit 1.0 and later
 */
@interface NSTabView (M3Extensions)

/**
 Returns the index of the currently selected tab
 Equivalent to [self indexOfTabViewItem:[self selectedTabViewItem]]
 @result Returns the index of the currently selected tab
 @since M3AppKit 1.0 and later
 */
- (NSInteger)indexOfSelectedTab;

@end
