/*****************************************************************
 M3DualViewController.m
 M3AppKit
 
 Created by Martin Pilkington on 05/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3DualViewController.h"

#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070
@interface M3DualViewController () 

- (CGFloat)_hiddenConstantFromFrame:(NSRect)aFrame constraintType:(NSLayoutAttribute)aType;

@end


@implementation M3DualViewController



@synthesize secondaryViewConstraint;
@synthesize secondaryView;

- (BOOL)isSecondaryViewVisible {
	return [[self secondaryViewConstraint] constant] == 0;
}

- (void)showSecondaryViewAnimated:(BOOL)aAnimated {
	[[self secondaryView] setHidden:NO];
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		[context setDuration:aAnimated ? 0.4 : 0];
		[context setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[[secondaryViewConstraint animator] setConstant:0];
	} completionHandler:nil];
}

- (void)hideSecondaryViewAnimated:(BOOL)aAnimated {
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		[context setDuration:aAnimated ? 0.4 : 0];
		[context setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		CGFloat constant = [self _hiddenConstantFromFrame:[[self secondaryView] frame] 
										   constraintType:[[self secondaryViewConstraint] firstAttribute]];
		[[secondaryViewConstraint animator] setConstant:constant];
	} completionHandler:^{
		[[self secondaryView] setHidden:YES];
	}];
}

- (CGFloat)_hiddenConstantFromFrame:(NSRect)aFrame constraintType:(NSLayoutAttribute)aType {
	if (aType == NSLayoutAttributeLeft || aType == NSLayoutAttributeLeading) {
		return -aFrame.size.width;
	} else if (aType == NSLayoutAttributeRight || aType == NSLayoutAttributeTrailing) {
		return aFrame.size.width;
	} else if (aType == NSLayoutAttributeTop) {
		return -aFrame.size.height;
	} else if (aType == NSLayoutAttributeBottom) {
		return aFrame.size.height;
	}
	NSAssert(YES, @"You must use a Left, Right, Top, Bottom, Leading or Trailing attribute");
	return 0;
}

@end

#endif