/*****************************************************************
 M3NavigationView.h
 M3AppKit
 
 Created by Martin Pilkington on 18/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>
#import "M3NavigationViewProtocol.h"

@protocol M3NavigationViewDelegate;
@interface M3NavigationView : NSView

@property (readonly) NSViewController *currentViewController;
@property (assign) __weak IBOutlet id <M3NavigationViewDelegate>delegate;
@property (nonatomic, assign) BOOL showsNavigationBar;

- (void)pushViewController:(NSViewController<M3NavigationViewProtocol> *)controller animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;

//Convenience method
- (void)pushView:(NSView *)aView animated:(BOOL)aAnimated;

@end

@protocol M3NavigationViewDelegate <NSObject>

@optional;
- (void)navigationView:(M3NavigationView *)aView didReplaceViewController:(id)aOldController withViewController:(id)aNewController;

@end