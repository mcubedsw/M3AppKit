/*****************************************************************
 NSLayoutConstraint+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 22/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 A set of convenience methods for creating common constraints
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSLayoutConstraint (M3Extensions)

/**
 Create a fixed width constraint for the supplied view
 @param aView The view to constrain the width of
 @param aConstant The width to use
 @return A newly initialised layout constraint
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_fixedWidthConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant;

/**
 Create a fixed height constraint for the supplied view
 @param aView The view to constraint the height of
 @param aConstant The height to use
 @return A newly initialised layout constraint
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_fixedHeightConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant;

/**
 Create an equal width constraint between the supplied views
 @param aView The first view to constraint
 @param aSecondView The second view to constraint to the width of the first
 @return A newly initialised layout constraint
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_equalWidthsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView;

/**
 Create an equal height constraint between the supplied views
 @param aView The first view to constraint
 @param aSecondView The second view to constraint to the height of the first
 @return A newly initialised layout constraint
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_equalHeightsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView;

/**
 Create a constraint between a view and its superview
 @param aView The view to constraint
 @param aAttribute The attribute to constraint
 @param aConstant The constant value to use
 @return A newly initialised layout constraint
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_superviewConstraintWithView:(NSView *)aView attribute:(NSLayoutAttribute)aAttribute constant:(CGFloat)aConstant;

@end