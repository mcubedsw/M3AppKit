//
//  NSView+M3AutolayoutExtensions.h
//  M3AppKit
//
//  Created by Martin Pilkington on 01/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*
 Stuff to add
 --------------
 Change .super to .margins
 Add $super to expand to $self.superview
 Add .center to expand to .(centerX, centerY)
 Imply $super.property for all attributes bar width/height
 Add priority support, after the relationship have (@xxx) for the priority, e.g. =(@700)
 Add support for multiplication before property, e.g. 2.5($view.property)
 */

/**
 Methods to help working with constraints on an NSView
 
 **Constraint String Syntax**
 This category contains the method -m3_addConstraints:forViews:. While it looks simple, it actually provides an extremely powerful and
 expressive way to create and add constraints to a view. Unfortunately the existing ways of creating layouts in code are either inflexible or
 verbose. The visual syntax allows adding multiple constraints in a concise way, but does not allow for all possibilities and limits you to a
 single axis at a time. The method syntax gives access to the full power of the autolayout system, but requires each constraint be created
 individually. This category adds a third syntax, the constraint string syntax
 
 Constraints represent equations of the form y = mx + c. The constraint syntax allows you to define your constraints in a similar way. The
 basic format is "$view.attributes = $otherview.attributes * multiplier + constant". You can use these to build up an array of strings that are
 passed in and used to create constraints.
 
 **Views**
 Constraint strings can act upon the receiver and/or any views supplied via the substitution views argument. This argument can take either
 an NSDictionary or an NSArray. Any substitution views MUST be children of the receiver (though need not be direct subviews).
 
 Views are used in constraint strings by writing a dollar sign, followed by the view name. The name will
 depend on the type of collection passed in. If an NSDictionary was passed in, the view names are the keys of that dictionary. If an NSArray
 was passed in, the view names are numbers from 0 to (array.count - 1). For example, for a dictionary @{@"foo":view1, @"bar":view2}, you would
 use "$foo" and "$bar" to access the views. For an array @[view1, view2] you would instead use "$0" and "$1".
 
 There are two special view names. The first of these is "$self" which refers to the receiver view. The second is "$all" which refers to all the
 substitution views passed in (but does not include the receiver). This is useful if you want to apply constraints to a long list of subviews.
 
 Finally, you can use key paths to access properties on the named views. The key path must result in a view being returned, but other than
 that there are no restrictions. This is useful if the receiver has subviews stored in properties that you want to refer to, and saves having to
 pass those in as a substitution variable
 
**Attributes**
 There are 13 attributes that can be used in constraint strings. The first 11 represent the layout attributes that you can use:
 
 * left = NSLayoutAttributeLeft
 * right = NSLayoutAttributeRight
 * top = NSLayoutAttributeTop
 * bottom = NSLayoutAttributeBottom
 * leading = NSLayoutAttributeLeading
 * trailing = NSLayoutAttributeTrailing
 * width = NSLayoutAttributeWidth
 * height = NSLayoutAttributeHeight
 * centerX = NSLayoutAttributeCenterX
 * centerY = NSLayoutAttributeCenterY
 * baseline = NSLayoutAttributeBaseline
 
 The other two are special attributes that expand to attribute lists (see the Lists section for more). These are:
 
 * super = (top, leading, bottom, trailing)
 * size = (width, height)
 
 **Constants And Multipliers**
 Constants and multipliers can be defined as integer or floating point values. They are used to modify the equation. By default the multiplier
 is set to 1 and the constant to 0. If you leave either of these out of an equation the default will be used. These values must always be ordered
 multiplier first, constant second. Multipliers are prefixed with the * symbol and constants by either the + or - symbol (unless they're
 standalone constants, in which case the + is not required for positive constants).
 
  **Relationships**
 There are three types of relationship possible with autolayout. Equals, less than or equal to and greater than or equal to. These are defined
 in constraint strings as =, <= and >= respectively
 
 **Lists**
 A constraint string can represent multiple constraints. It does this through lists. Lists are defined as comma separated values within brackets.
 For example, a constant list might be (0, 1, 2, 3) and a attribute list might be (top, bottom). As noted above, there are some special attributes
 that are infact lists themselves. This simplifies some more common lists.
 
 The components on the right hand side of the equation must have either a single value, or a list equal to the size of the list on the left hand
 side. The easiest way to demonstrate this is through some examples. The following are all valid:
 
 * $self.(width, height) = 10
 * $self.(width, height) = (10, 5)
 * $self.(width, height) = $x.width
 * $self.(width, height) = $x.(width, height)
 * $self.(width, height) = $x.(width, height) * 2 + 4
 
 Note the last string will set the width to "x.width * 2 + 4" and the height to "x.height * 2 + 4". The following constraint strings are all invalid:
 
 * $self.(width, height) = (10, 4, 5)
 * $self.(width, height) = (10)
 * $self.width = $x.(width, height)
 
 Sometimes you may not want to specify constants for certain list items. To allow for this, constant lists let you specify "-" as the value.
 For example, an equation "$self.super = (10, -, 10, -)" will only create two constraints and is equivalent to "$self.(top, bottom) = (10, 10)"
 
 **What Isn't Supported**
 Currently the syntax is very rigid. As stated above, you must have the multiplier after the property. In future it will be possible to specify it
 with more flexibility, and to add brackets to aid readability. This system also doesn't yet support priorities, all constraints are created at
 the require priority (1000). This will be added in the future
 
 
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSView (M3AutolayoutExtensions)

/**
 Adds a subview to the receiver, with the initial superview constraints defined by the inset
 @param aSubview The subview to add
 @param aInsets The margin the subview should have from each edge of the receiver
 @since PROJECT_NAME VERSION_NAME or later
 */
- (void)m3_addSubview:(NSView *)aSubview andFillConstraintsWithInset:(NSEdgeInsets)aInsets;

/**
 Adds the supplied constraints to the subview
 @param aConstraints An array of constraint strings
 @param aSubstitutionViews A collection of substitution views to use in the constraint strings
 @since PROJECT_NAME VERSION_NAME or later
 */
- (void)m3_addConstraintsFromStrings:(NSArray *)aConstraints forViews:(id)aSubstitutionViews;

@end
