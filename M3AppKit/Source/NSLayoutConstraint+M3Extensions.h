/*****************************************************************
 NSLayoutConstraint+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 22/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

@interface NSLayoutConstraint (M3Extensions)

+ (NSLayoutConstraint *)m3_fixedWidthConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant;
+ (NSLayoutConstraint *)m3_fixedHeightConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant;
+ (NSLayoutConstraint *)m3_equalWidthsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView;
+ (NSLayoutConstraint *)m3_equalHeightsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView;
+ (NSLayoutConstraint *)m3_superviewConstraintWithView:(NSView *)aView attribute:(NSLayoutAttribute)aAttribute constant:(CGFloat)aConstant;

@end

#endif