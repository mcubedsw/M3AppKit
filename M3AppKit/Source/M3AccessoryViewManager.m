/*****************************************************************
 M3AccessoryViewManager.m
 M3AppKit
 
 Created by Martin Pilkington on 05/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3AccessoryViewManager.h"


@implementation M3AccessoryViewManager


- (BOOL)isAccessoryViewVisible {
	return self.accessoryViewConstraint.constant == 0;
}


- (void)showAccessoryViewAnimated:(BOOL)aAnimated {
	[self.accessoryView setHidden:NO];
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		[context setDuration:aAnimated ? 0.4 : 0];
		[context setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[[self.accessoryViewConstraint animator] setConstant:0];
	} completionHandler:nil];
}


- (void)hideAccessoryViewAnimated:(BOOL)aAnimated {
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		[context setDuration:aAnimated ? 0.4 : 0];
		[context setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		
		CGFloat constant = [self hiddenConstantFromFrame:self.accessoryView.frame
										  constraintType:self.accessoryViewConstraint.firstAttribute];
		[[self.accessoryViewConstraint animator] setConstant:constant];
	} completionHandler:^{
		[self.accessoryView setHidden:YES];
	}];
}


- (CGFloat)hiddenConstantFromFrame:(NSRect)aFrame constraintType:(NSLayoutAttribute)aType {
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

- (IBAction)showAccessoryView:(id)aSender {
	[self showAccessoryViewAnimated:YES];
}

- (IBAction)hideAccessoryView:(id)aSender {
	[self hideAccessoryViewAnimated:YES];
}

@end
