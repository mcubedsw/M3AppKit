/*****************************************************************
 NSLayoutConstraint+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 22/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSLayoutConstraint (M3Extensions)

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_fixedWidthConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_fixedHeightConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_equalWidthsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_equalHeightsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
+ (NSLayoutConstraint *)m3_superviewConstraintWithView:(NSView *)aView attribute:(NSLayoutAttribute)aAttribute constant:(CGFloat)aConstant;

@end