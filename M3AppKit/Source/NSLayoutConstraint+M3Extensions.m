//
//  NSLayoutConstraint+M3Extensions.m
//  M3ConstraintBasedSplitView
//
//  Created by Martin Pilkington on 22/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "NSLayoutConstraint+M3Extensions.h"
#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

@implementation NSLayoutConstraint (M3Extensions)

+ (NSLayoutConstraint *)m3_fixedWidthConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant {
	return [NSLayoutConstraint constraintWithItem:aView 
										attribute:NSLayoutAttributeWidth 
										relatedBy:NSLayoutRelationEqual
										   toItem:nil
										attribute:0
									   multiplier:1
										 constant:aConstant];
}

+ (NSLayoutConstraint *)m3_fixedHeightConstraintWithView:(NSView *)aView constant:(CGFloat)aConstant {
	return [NSLayoutConstraint constraintWithItem:aView 
										attribute:NSLayoutAttributeHeight 
										relatedBy:NSLayoutRelationEqual
										   toItem:nil
										attribute:0
									   multiplier:1
										 constant:aConstant];
}

+ (NSLayoutConstraint *)m3_equalWidthsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView {
	return [NSLayoutConstraint constraintWithItem:aView 
										attribute:NSLayoutAttributeWidth 
										relatedBy:NSLayoutRelationEqual
										   toItem:aSecondView
										attribute:NSLayoutAttributeWidth
									   multiplier:1
										 constant:0];
}

+ (NSLayoutConstraint *)m3_equalHeightsConstraintWithView:(NSView *)aView andView:(NSView *)aSecondView {
	return [NSLayoutConstraint constraintWithItem:aView 
										attribute:NSLayoutAttributeHeight 
										relatedBy:NSLayoutRelationEqual
										   toItem:aSecondView
										attribute:NSLayoutAttributeHeight
									   multiplier:1
										 constant:0];
}

+ (NSLayoutConstraint *)m3_superviewConstraintWithView:(NSView *)aView attribute:(NSLayoutAttribute)aAttribute constant:(CGFloat)aConstant {
	return [NSLayoutConstraint constraintWithItem:aView 
										attribute:aAttribute 
										relatedBy:NSLayoutRelationEqual
										   toItem:[aView superview]
										attribute:aAttribute
									   multiplier:1
										 constant:aConstant];
}

@end

#endif