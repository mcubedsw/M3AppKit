/*****************************************************************
NSView+M3Extensions.h
M3Extensions

Created by Martin Pilkington on 24/07/2009.

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
 @category NSView(M3Extensions)
 Some methods on NSView to make life easier
 @since Available in M3AppKit 1.0 and later
 */
@interface NSView(M3Extensions)

/**
 Recurses the view heirachy to see if the supplied view is contained within the receiver
 @param aView The view to search for
 @result YES if the receiver contains the view, otherwise NO
 @since Available in M3AppKit 1.0 and later
 */
- (BOOL)m3_containsView:(NSView *)aView;

/**
 Returns a more descriptive name for the view
 <b>Discussion</b>
 For example, for a button with the label "Cancel" this will return "NSButton (Cancel)". The output of this method should not be relied upon to be the same between versions.
 @result The name for the view
 @since Available in M3AppKit 1.0 and later
 */
- (NSString *)m3_viewName;

- (void)m3_bringViewToFront;
- (void)m3_sendViewToBack;
- (void)m3_sortSubviewsUsingBlock:(NSComparator)aComparator;

/**
 Removes all the subviews from the receiver
 @since Available in M3AppKit 1.0 and later
 */
- (void)removeAllSubviews;

#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets;
- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets animated:(BOOL)aAnimated;

#endif

@end
