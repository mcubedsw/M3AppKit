/*****************************************************************
 M3DualViewController.h
 M3AppKit
 
 Created by Martin Pilkington on 05/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>
#import <AvailabilityMacros.h>


#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

@interface M3DualViewController : NSObject 

@property (assign) IBOutlet NSLayoutConstraint *secondaryViewConstraint;
@property (assign) IBOutlet NSView *secondaryView;
@property (readonly, getter = isSecondaryViewVisible) BOOL secondaryViewVisible;

- (void)showSecondaryViewAnimated:(BOOL)aAnimated;
- (void)hideSecondaryViewAnimated:(BOOL)aAnimated;

@end

#endif
