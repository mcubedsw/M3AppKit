/*****************************************************************
 NSView+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 24/07/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 Some methods on NSView to make life easier
 @since M3AppKit 1.0 and later
 */
@interface NSView(M3Extensions)

/**
 Recurses the view heirachy to see if the supplied view is contained within the receiver
 @param aView The view to search for
 @result YES if the receiver contains the view, otherwise NO
 @since M3AppKit 1.0 and later
 */
- (BOOL)m3_containsView:(NSView *)aView;

/**
 Returns a more descriptive name for the view
 <b>Discussion</b>
 For example, for a button with the label "Cancel" this will return "NSButton (Cancel)". The output of this method should not be relied upon to be the same between versions.
 @result The name for the view
 @since M3AppKit 1.0 and later
 */
- (NSString *)m3_viewName;

/**
 Brings the receiver to the front of its parent's subview list
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_bringViewToFront;

/**
 Sends the receiver to the back of its parent's subview list
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_sendViewToBack;

/**
 Sorts the receiver's subviews using the supplied block
 @param aComparator A comparator block for determining the sort order of views
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_sortSubviewsUsingBlock:(NSComparator)aComparator;

/**
 Removes all the subviews from the receiver
 @since M3AppKit 1.0 and later
 */
- (void)m3_removeAllSubviews;

@end
