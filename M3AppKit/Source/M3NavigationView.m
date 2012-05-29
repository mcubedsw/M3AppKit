/*****************************************************************
 M3NavigationView.h
 M3Extensions
 
 Created by Martin Pilkington on 18/11/2008.
 
 Copyright (c) 2006-2010 M Cubed Software
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 *****************************************************************/

#import "M3NavigationView.h"

#define M3HeaderHeight 34

NSString *M3NavigationController = @"M3NavigationController";
NSString *M3NavigationTitleField = @"M3NavigationTitleField";
NSString *M3NavigationBackButton = @"M3NavigationBackButton";

typedef enum {
	M3NavigationAnimationDirectionNone = 0,
	M3NavigationAnimationDirectionLeft = 1,
	M3NavigationAnimationDirectionRight = 2
} M3NavigationAnimationDirection;


@interface M3NavigationView () {
	NSMutableArray *controllerStack;
}

- (void)_setup;

- (NSRect)_headerRect;
- (NSRect)_contentRect;
- (NSRect)_backButtonRect;
- (NSRect)_titleRectWithX:(CGFloat)aX;

- (NSButton *)_createBackButton;
- (NSTextField *)_createTextFieldWithTitle:(NSString *)aTitle;

- (void)_swapView:(NSView *)aOldView withView:(NSView *)aNewView desiredRect:(NSRect)aDesiredRect direction:(M3NavigationAnimationDirection)aDirection fade:(BOOL)aFade;
- (CAAnimationGroup *)_animationFromPoint:(NSPoint)aFromPoint toPoint:(NSPoint)aToPoint fromOpacity:(CGFloat)aFromOpacity toOpacity:(CGFloat)aToOpacity;

@end


@implementation M3NavigationView

@synthesize delegate, showsNavigationBar;

/***************************
 
 **************************/
- (id)initWithFrame:(NSRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self _setup];
	}
    return self;
}

/***************************
 
 **************************/
- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self _setup];
	}
	return self;
}

/***************************
 
 **************************/
- (void)_setup {
	showsNavigationBar = YES;
	controllerStack = [[NSMutableArray alloc] init];
}

- (void)setShowsNavigationBar:(BOOL)aShowsNavigationBar {
	showsNavigationBar = aShowsNavigationBar;
	[self setNeedsDisplay:YES];
}

/***************************
 
 **************************/
- (void)drawRect:(NSRect)dirtyRect {
	if (![self showsNavigationBar])
		return;
	NSRect headerRect = [self _headerRect];
	NSGradient *headerGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0.956 green:0.961 blue:0.955 alpha:1.000] 
															   endingColor:[NSColor colorWithCalibratedWhite:0.826 alpha:1.000]];
	[headerGradient drawInRect:headerRect angle:-90];
	
	[[NSColor colorWithCalibratedWhite:0.415 alpha:1.000] set];
	[NSBezierPath strokeLineFromPoint:NSMakePoint(0, NSMinY(headerRect)-0.5) toPoint:NSMakePoint(NSMaxX(headerRect), NSMinY(headerRect)-0.5)];
}





#pragma mark -
#pragma mark Rects

/***************************
 
 **************************/
- (NSRect)_headerRect {
	return NSMakeRect(0, [self bounds].size.height-M3HeaderHeight, [self bounds].size.width, M3HeaderHeight);
}

/***************************
 
 **************************/
- (NSRect)_backButtonRect {
	return NSMakeRect(5, NSMidY([self _headerRect])-11, 36, 21);
}

/***************************
 
 **************************/
- (NSRect)_titleRectWithX:(CGFloat)aX {
	CGFloat width = [self _headerRect].size.width - aX - 15;
	return NSMakeRect(aX, NSMidY([self _headerRect])-11, width, 20);
}

/***************************
 
 **************************/
- (NSRect)_contentRect {
	if ([self showsNavigationBar]) {
		return NSMakeRect(0, 0, [self bounds].size.width, [self bounds].size.height-M3HeaderHeight-1);
	}
	return [self bounds];
}





#pragma mark -
#pragma mark Header Views

/***************************
 
 **************************/
- (NSButton *)_createBackButton {
	NSButton *button = [[NSButton alloc] initWithFrame:[self _backButtonRect]];
	[button setFrameOrigin:NSZeroPoint];
	[button setButtonType:NSMomentaryChangeButton];
	[button setBordered:NO];
	[button setTarget:self];
	[button setAction:@selector(_back:)];
	[button setAutoresizingMask:NSViewMaxXMargin|NSViewMinYMargin];
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.mcubedsw.M3AppKit"];
#ifdef M3APPKIT_IB_BUILD
	bundle = [NSBundle bundleWithIdentifier:@"com.mcubedsw.M3AppKitIB"];
#endif
	[button setImage:[[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"NavigationViewBackButton"]]];
	[button setAlternateImage:[[NSImage alloc] initWithContentsOfFile:[bundle pathForImageResource:@"NavigationViewBackButtonAlternate"]]];
	
	return button;
}

/***************************
 
 **************************/
- (NSTextField *)_createTextFieldWithTitle:(NSString *)aTitle {
	NSTextField *titleField = [[NSTextField alloc] initWithFrame:[self _titleRectWithX:0]];
	[titleField setFrameOrigin:NSZeroPoint];
	[titleField setStringValue:aTitle?:@""];
	[titleField setEditable:NO];
	[titleField setSelectable:NO];
	[titleField setBordered:NO];
	[titleField setDrawsBackground:NO];
	[titleField setFont:[NSFont boldSystemFontOfSize:14]];
	[titleField setTextColor:[NSColor colorWithCalibratedWhite:0.195 alpha:1.000]];
	[titleField setAlignment:NSCenterTextAlignment];
	[[titleField cell] setLineBreakMode:NSLineBreakByTruncatingTail];
	[titleField setAutoresizingMask:NSViewWidthSizable|NSViewMinYMargin];
	return titleField;
}

/***************************
 
 **************************/
- (void)_back:(id)sender {
	[self popViewControllerAnimated:YES];
}





#pragma mark -
#pragma mark Manage View Controllers

/***************************
 
 **************************/
- (NSViewController *)currentViewController {
	return [[controllerStack lastObject] objectForKey:M3NavigationController];
}

/***************************
 
 **************************/
- (void)pushView:(NSView *)aView animated:(BOOL)aAnimated {
	NSViewController *viewController = [[NSViewController alloc] init];
	[viewController setView:aView];
	[self pushViewController:(id)viewController animated:aAnimated];
}

/***************************
 
 **************************/
- (void)pushViewController:(NSViewController<M3NavigationViewProtocol> *)aController animated:(BOOL)aAnimated {
	[[aController view] setAutoresizingMask:NSViewWidthSizable|NSViewHeightSizable];
	if ([aController respondsToSelector:@selector(setNavigationView:)]) {
		[aController setNavigationView:self];
	}
	
	NSDictionary *previousControllerDict = [controllerStack lastObject];
	NSDictionary *currentController = [NSDictionary dictionaryWithObjectsAndKeys:aController, M3NavigationController, [self _createBackButton], M3NavigationBackButton, [self _createTextFieldWithTitle:[aController title]], M3NavigationTitleField, nil];
	[controllerStack addObject:currentController];
	
	//Check if we're the first
	CGFloat titleX = NSMaxX([self _backButtonRect]);
	if ([controllerStack count] == 1) {
		[[currentController objectForKey:M3NavigationBackButton] setHidden:YES];
		titleX = 15;
		aAnimated = NO;
	}
	
	//Swap views
	[self _swapView:[[previousControllerDict objectForKey:M3NavigationController] view]
		   withView:[[currentController objectForKey:M3NavigationController] view]
		desiredRect:[self _contentRect]
		  direction:aAnimated ? M3NavigationAnimationDirectionLeft : M3NavigationAnimationDirectionNone
			   fade:NO];
	
	if ([self showsNavigationBar]) {
		[self _swapView:[previousControllerDict objectForKey:M3NavigationBackButton] 
			   withView:[currentController objectForKey:M3NavigationBackButton]
			desiredRect:[self _backButtonRect]
			  direction:aAnimated ? M3NavigationAnimationDirectionLeft : M3NavigationAnimationDirectionNone
				   fade:YES];
		
		[self _swapView:[previousControllerDict objectForKey:M3NavigationTitleField] 
			   withView:[currentController objectForKey:M3NavigationTitleField]
			desiredRect:[self _titleRectWithX:titleX]
			  direction:aAnimated ? M3NavigationAnimationDirectionLeft : M3NavigationAnimationDirectionNone
				   fade:YES];
	}
	
	if ([aController respondsToSelector:@selector(activateView)]) {
		[aController activateView];
	}
	if ([[self delegate] respondsToSelector:@selector(navigationView:didReplaceViewController:withViewController:)]) {
		[[self delegate] navigationView:self
			   didReplaceViewController:[previousControllerDict objectForKey:M3NavigationController]
					 withViewController:[currentController objectForKey:M3NavigationController]];
	}
}

/***************************
 
 **************************/
- (void)popViewControllerAnimated:(BOOL)aAnimated {
	if ([controllerStack count] == 1)
		return;
	
	//Get dictionaries
	NSDictionary *previousControllerDict = [controllerStack lastObject];
	[controllerStack removeLastObject];
	NSDictionary *currentController = [controllerStack lastObject];
	
	//Get title X
	CGFloat titleX = NSMaxX([self _backButtonRect]);
	if ([controllerStack count] == 1) {
		titleX = 15;
	}
	
	//Swap views
	[self _swapView:[[previousControllerDict objectForKey:M3NavigationController] view]
		   withView:[[currentController objectForKey:M3NavigationController] view]
		desiredRect:[self _contentRect]
		  direction:aAnimated ? M3NavigationAnimationDirectionRight : M3NavigationAnimationDirectionNone
			   fade:NO];
	
	if ([self showsNavigationBar]) {
		[self _swapView:[previousControllerDict objectForKey:M3NavigationBackButton] 
			   withView:[currentController objectForKey:M3NavigationBackButton]
			desiredRect:[self _backButtonRect]
			  direction:aAnimated ? M3NavigationAnimationDirectionRight : M3NavigationAnimationDirectionNone
				   fade:YES];
		
		[self _swapView:[previousControllerDict objectForKey:M3NavigationTitleField] 
			   withView:[currentController objectForKey:M3NavigationTitleField]
			desiredRect:[self _titleRectWithX:titleX]
			  direction:aAnimated ? M3NavigationAnimationDirectionRight : M3NavigationAnimationDirectionNone
				   fade:YES];
	}
	
	if ([[currentController objectForKey:M3NavigationController] respondsToSelector:@selector(activateView)]) {
		[[currentController objectForKey:M3NavigationController] activateView];
	}
	
	if ([[self delegate] respondsToSelector:@selector(navigationView:didReplaceViewController:withViewController:)]) {
		[[self delegate] navigationView:self
			   didReplaceViewController:[previousControllerDict objectForKey:M3NavigationController]
					 withViewController:[currentController objectForKey:M3NavigationController]];
	}
}





#pragma mark -
#pragma mark View Replacement

/***************************
 
 **************************/
- (void)_swapView:(NSView *)aOldView withView:(NSView *)aNewView desiredRect:(NSRect)aDesiredRect direction:(M3NavigationAnimationDirection)aDirection fade:(BOOL)aFade {
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
	CAAnimationGroup *outAnim = [self _animationFromPoint:[aOldView frame].origin toPoint:outRect.origin fromOpacity:1 toOpacity:(aFade ? 0 : 1)];
	[aOldView setAnimations:[NSDictionary dictionaryWithObject:outAnim forKey:@"frameOrigin"]];
	
	CAAnimationGroup *inAnim = [self _animationFromPoint:inRect.origin toPoint:aDesiredRect.origin fromOpacity:(aFade ? 0 : 1) toOpacity:1];
	[aNewView setAnimations:[NSDictionary dictionaryWithObject:inAnim forKey:@"frameOrigin"]];
	
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

/***************************
 
 **************************/
- (CAAnimationGroup *)_animationFromPoint:(NSPoint)aFromPoint toPoint:(NSPoint)aToPoint fromOpacity:(CGFloat)aFromOpacity toOpacity:(CGFloat)aToOpacity {
	CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"frameOrigin"];
	[moveAnim setValues:[NSArray arrayWithObjects:[NSValue valueWithPoint:aFromPoint], [NSValue valueWithPoint:aToPoint], nil]];
	[moveAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
	
	CABasicAnimation *fadeAnim = [CABasicAnimation animationWithKeyPath:@"alphaValue"];
	[fadeAnim setFromValue:[NSNumber numberWithFloat:aFromOpacity]];
	[fadeAnim setToValue:[NSNumber numberWithFloat:aToOpacity]];
	
	CAAnimationGroup *group = [CAAnimationGroup animation];
	[group setAnimations:[NSArray arrayWithObjects:moveAnim, fadeAnim, nil]];
	return group;
}

@end