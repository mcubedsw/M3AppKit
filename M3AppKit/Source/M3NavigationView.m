/*****************************************************************
 M3NavigationView.m
 M3AppKit
 
 Created by Martin Pilkington on 18/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3NavigationView.h"
#import "M3NavigationSubviewProtocol.h"

const NSUInteger M3HeaderHeight = 34;

NSString *M3NavigationController = @"M3NavigationController";
NSString *M3NavigationTitleField = @"M3NavigationTitleField";
NSString *M3NavigationBackButton = @"M3NavigationBackButton";

typedef enum {
	M3NavigationAnimationDirectionNone = 0,
	M3NavigationAnimationDirectionLeft = 1,
	M3NavigationAnimationDirectionRight = 2
} M3NavigationAnimationDirection;





@interface M3NavigationView () 

- (void)p_setup;

- (NSRect)p_headerRect;
- (NSRect)p_contentRect;
- (NSRect)p_backButtonRect;
- (NSRect)p_titleRectWithX:(CGFloat)aX;

- (NSButton *)p_createBackButton;
- (NSTextField *)p_createTextFieldWithTitle:(NSString *)aTitle;

- (void)p_swapView:(NSView *)aOldView withView:(NSView *)aNewView desiredRect:(NSRect)aDesiredRect direction:(M3NavigationAnimationDirection)aDirection fade:(BOOL)aFade;
- (CAAnimationGroup *)p_animationFromPoint:(NSPoint)aFromPoint toPoint:(NSPoint)aToPoint fromOpacity:(CGFloat)aFromOpacity toOpacity:(CGFloat)aToOpacity;

@end





@implementation M3NavigationView {
	NSMutableArray *controllerStack;
}

//*****//
- (id)initWithFrame:(NSRect)aFrame {
	if ((self = [super initWithFrame:aFrame])) {
		[self p_setup];
	}
    return self;
}

//*****//
- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self p_setup];
	}
	return self;
}

//*****//
- (void)p_setup {
	_showsNavigationBar = YES;
	controllerStack = [NSMutableArray new];
}

//*****//
- (void)setShowsNavigationBar:(BOOL)aShowsNavigationBar {
	_showsNavigationBar = aShowsNavigationBar;
	[self setNeedsDisplay:YES];
}

//*****//
- (void)drawRect:(NSRect)aDirtyRect {
	if (!self.showsNavigationBar) return;

	//Draw the header
	NSRect headerRect = self.p_headerRect;
	NSGradient *headerGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.956 green:0.961 blue:0.955 alpha:1.000] 
															   endingColor:[NSColor colorWithCalibratedWhite:0.826 alpha:1.000]];
	[headerGradient drawInRect:headerRect angle:-90];
	
	[[NSColor colorWithCalibratedWhite:0.415 alpha:1.000] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, NSMinY(headerRect)-0.5)
							  toPoint:NSMakePoint(NSMaxX(headerRect), NSMinY(headerRect)-0.5)];
}





#pragma mark -
#pragma mark Rects

//*****//
- (NSRect)p_headerRect {
	return NSMakeRect(0, (self.bounds.size.height - M3HeaderHeight), self.bounds.size.width, M3HeaderHeight);
}

//*****//
- (NSRect)p_backButtonRect {
	return NSMakeRect(5, NSMidY(self.p_headerRect) - 11, 36, 21);
}

//*****//
- (NSRect)p_titleRectWithX:(CGFloat)aX {
	CGFloat width = self.p_headerRect.size.width - aX - 15;
	return NSMakeRect(aX, NSMidY(self.p_headerRect) - 11, width, 20);
}

//*****//
- (NSRect)p_contentRect {
	if (self.showsNavigationBar) {
		return NSMakeRect(0, 0, self.bounds.size.width, (self.bounds.size.height - M3HeaderHeight - 1));
	}
	return self.bounds;
}





#pragma mark -
#pragma mark Header Views

//*****//
- (NSButton *)p_createBackButton {
	NSButton *button = [[NSButton alloc] initWithFrame:self.p_backButtonRect];
	[button setFrameOrigin:NSZeroPoint];
	[button setButtonType:NSMomentaryChangeButton];
	[button setBordered:NO];
	[button setTarget:self];
	[button setAction:@selector(p_back:)];
	[button setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.mcubedsw.M3AppKit"];
	[button setImage:[[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"NavigationViewBackButton"]]];
	[button setAlternateImage:[[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"NavigationViewBackButtonAlternate"]]];
	
	return button;
}

//*****//
- (NSTextField *)p_createTextFieldWithTitle:(NSString *)aTitle {
	NSTextField *titleField = [[NSTextField alloc] initWithFrame:[self p_titleRectWithX:0]];
	[titleField setFrameOrigin:NSZeroPoint];
	[titleField setStringValue:aTitle?:@""];
	[titleField setEditable:NO];
	[titleField setSelectable:NO];
	[titleField setBordered:NO];
	[titleField setDrawsBackground:NO];
	[titleField setFont:[NSFont boldSystemFontOfSize:14]];
	[titleField setTextColor:[NSColor colorWithCalibratedWhite:0.195 alpha:1.000]];
	[titleField setAlignment:NSCenterTextAlignment];
	[titleField.cell setLineBreakMode:NSLineBreakByTruncatingTail];
	[titleField setAutoresizingMask:NSViewWidthSizable|NSViewMinYMargin];
	return titleField;
}

//*****//
- (void)p_back:(id)sender {
	[self popViewControllerAnimated:YES];
}





#pragma mark -
#pragma mark Manage View Controllers

//*****//
- (NSViewController *)currentViewController {
	return controllerStack.lastObject[M3NavigationController];
}

//*****//
- (void)pushView:(NSView *)aView animated:(BOOL)aAnimated {
	NSViewController *viewController = [NSViewController new];
	[viewController setView:aView];
	[self pushViewController:viewController animated:aAnimated];
}

//*****//
- (void)pushViewController:(NSViewController<M3NavigationSubview> *)aController animated:(BOOL)aAnimated {
	[aController.view setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
	if ([aController respondsToSelector:@selector(setNavigationView:)]) {
		[aController setNavigationView:self];
	}
	
	NSDictionary *previousControllerDict = controllerStack.lastObject;
	NSDictionary *currentController = @{
		M3NavigationController:aController,
		M3NavigationBackButton:[self p_createBackButton],
		M3NavigationTitleField:[self p_createTextFieldWithTitle:aController.title]
	};
	[controllerStack addObject:currentController];
	
	//Check if we're the first
	CGFloat titleX = NSMaxX(self.p_backButtonRect);
	if (controllerStack.count == 1) {
		[currentController[M3NavigationBackButton] setHidden:YES];
		titleX = 15;
		aAnimated = NO;
	}
	
	//Swap views
	[self p_swapView:[previousControllerDict[M3NavigationController] view]
			withView:[currentController[M3NavigationController] view]
		 desiredRect:self.p_contentRect
		   direction:aAnimated ? M3NavigationAnimationDirectionLeft : M3NavigationAnimationDirectionNone
				fade:NO];
	
	if (self.showsNavigationBar) {
		[self p_swapView:previousControllerDict[M3NavigationBackButton]
				withView:currentController[M3NavigationBackButton]
			 desiredRect:self.p_backButtonRect
			   direction:aAnimated ? M3NavigationAnimationDirectionLeft : M3NavigationAnimationDirectionNone
					fade:YES];
		
		[self p_swapView:previousControllerDict[M3NavigationTitleField]
				withView:currentController[M3NavigationTitleField]
			 desiredRect:[self p_titleRectWithX:titleX]
			   direction:aAnimated ? M3NavigationAnimationDirectionLeft : M3NavigationAnimationDirectionNone
					fade:YES];
	}
	
	if ([aController respondsToSelector:@selector(activateView)]) {
		[aController activateView];
	}

	if ([self.delegate respondsToSelector:@selector(navigationView:didReplaceViewController:withViewController:)]) {
		[self.delegate navigationView:self
			 didReplaceViewController:previousControllerDict[M3NavigationController]
				   withViewController:currentController[M3NavigationController]];
	}
}

//*****//
- (NSViewController *)popViewControllerAnimated:(BOOL)aAnimated {
	if (controllerStack.count == 1) {
		return nil;
	}
	
	//Get dictionaries
	NSDictionary *previousControllerDict = controllerStack.lastObject;
	[controllerStack removeLastObject];
	NSDictionary *currentController = controllerStack.lastObject;
	
	//Get title X
	CGFloat titleX = NSMaxX(self.p_backButtonRect);
	if (controllerStack.count == 1) {
		titleX = 15;
	}
	
	//Swap views
	[self p_swapView:[previousControllerDict[M3NavigationController] view]
			withView:[currentController[M3NavigationController] view]
		 desiredRect:self.p_contentRect
		   direction:aAnimated ? M3NavigationAnimationDirectionRight : M3NavigationAnimationDirectionNone
				fade:NO];
	
	if (self.showsNavigationBar) {
		[self p_swapView:previousControllerDict[M3NavigationBackButton]
				withView:currentController[M3NavigationBackButton]
			 desiredRect:self.p_backButtonRect
			   direction:aAnimated ? M3NavigationAnimationDirectionRight : M3NavigationAnimationDirectionNone
					fade:YES];
		
		[self p_swapView:previousControllerDict[M3NavigationTitleField]
				withView:currentController[M3NavigationTitleField]
			 desiredRect:[self p_titleRectWithX:titleX]
			   direction:aAnimated ? M3NavigationAnimationDirectionRight : M3NavigationAnimationDirectionNone
					fade:YES];
	}
	
	if ([currentController[M3NavigationController] respondsToSelector:@selector(activateView)]) {
		[currentController[M3NavigationController] activateView];
	}
	
	if ([self.delegate respondsToSelector:@selector(navigationView:didReplaceViewController:withViewController:)]) {
		[self.delegate navigationView:self
			 didReplaceViewController:previousControllerDict[M3NavigationController]
				   withViewController:currentController[M3NavigationController]];
	}
	return previousControllerDict[M3NavigationController];
}





#pragma mark -
#pragma mark View Replacement

//*****//
- (void)p_swapView:(NSView *)aOldView withView:(NSView *)aNewView desiredRect:(NSRect)aDesiredRect direction:(M3NavigationAnimationDirection)aDirection fade:(BOOL)aFade {
	//Get rects
	NSRect inRect = aDesiredRect;
	NSRect outRect = aDesiredRect;
	if (aDirection == M3NavigationAnimationDirectionLeft) {
		inRect.origin.x = inRect.size.width;
		outRect.origin.x = -outRect.size.width;
	} else if (aDirection == M3NavigationAnimationDirectionRight) {
		inRect.origin.x = -inRect.size.width;
		outRect.origin.x = outRect.size.width;
	}
	
	//Get views
	[self addSubview:aNewView];
	[aNewView setFrame:inRect];
	
	//Add layer backing
	if (aFade) {
		[aOldView setWantsLayer:YES];
		[aNewView setWantsLayer:YES];
	}
	
	//Set up animations
	CAAnimationGroup *outAnim = [self p_animationFromPoint:aOldView.frame.origin toPoint:outRect.origin fromOpacity:1 toOpacity:(aFade ? 0 : 1)];
	[aOldView setAnimations:@{ @"frameOrigin":outAnim }];
	
	CAAnimationGroup *inAnim = [self p_animationFromPoint:inRect.origin toPoint:aDesiredRect.origin fromOpacity:(aFade ? 0 : 1) toOpacity:1];
	[aNewView setAnimations:@{ @"frameOrigin":inAnim }];
	
	//Perform animation
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		[context setDuration:aDirection == M3NavigationAnimationDirectionNone ? 0 : 0.55];
		
		[aNewView setAlphaValue:aFade ? 0 : 1];
		
		[[aOldView animator] setFrameOrigin:outRect.origin];
		[[aNewView animator] setFrameOrigin:aDesiredRect.origin];
	} completionHandler:^ {
		[aNewView setAlphaValue:1];
		[aNewView setWantsLayer:NO];
		[aOldView setWantsLayer:NO];
		[aOldView removeFromSuperview];
	}];
}

//*****//
- (CAAnimationGroup *)p_animationFromPoint:(NSPoint)aFromPoint toPoint:(NSPoint)aToPoint fromOpacity:(CGFloat)aFromOpacity toOpacity:(CGFloat)aToOpacity {
	CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"frameOrigin"];
	[moveAnim setValues:@[ [NSValue valueWithPoint:aFromPoint], [NSValue valueWithPoint:aToPoint] ]];
	[moveAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	CABasicAnimation *fadeAnim = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
	[fadeAnim setFromValue:[NSNumber numberWithFloat:aFromOpacity]];
	[fadeAnim setToValue:[NSNumber numberWithFloat:aToOpacity]];
	
	CAAnimationGroup *group = [CAAnimationGroup animation];
	[group setAnimations:@[ moveAnim, fadeAnim ]];
	return group;
}

@end