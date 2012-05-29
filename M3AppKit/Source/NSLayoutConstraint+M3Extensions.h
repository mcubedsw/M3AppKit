//
//  NSLayoutConstraint+M3Extensions.h
//  M3ConstraintBasedSplitView
//
//  Created by Martin Pilkington on 22/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

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