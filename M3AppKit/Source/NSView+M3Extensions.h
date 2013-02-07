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

/**
 Adds a subview to the receiver, with the initial superview constraints defined by the inset
 @param aSubview The subview to add
 @param aInsets The margin the subview should have from each edge of the receiver
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets;
#warning Remove
- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets animated:(BOOL)aAnimated;

/**
 Adds the supplied constraints to the subview
 
 For a detailed discussion of this method se
 @param aConstraints An array of constraint strings
 @param aSubstitutionViews A collection of substitution views to use in the constraint strings
 @since PROJECT_NAME VERSION_NAME or later
 */
- (void)m3_addConstraints:(NSArray *)aConstraints forViews:(id)aSubstitutionViews;

@end
