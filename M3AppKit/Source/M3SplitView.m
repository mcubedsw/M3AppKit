/*****************************************************************
 M3SplitView.m
 M3AppKit
 
 Created by Martin Pilkington on 19/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3SplitView.h"
#import "NSLayoutConstraint+M3Extensions.h"

@interface M3SplitView () 

- (void)setup;

- (NSUInteger)numberOfDividers;
- (NSRect)rectOfDividerAtIndex:(NSInteger)aIndex;
- (NSInteger)indexOfDividerAtPoint:(NSPoint)aPoint;

- (NSArray *)orderedSubviews;

- (NSLayoutConstraint *)constraintForView:(NSView *)aView;
- (void)clearSplitConstraints;

- (NSString *)splitViewConstantsKey;

- (NSRect)rectForKnobImageOfSize:(NSSize)aImageSize inDividerRect:(NSRect)aDividerRect;

- (NSArray *)constraintsForNonResizingViews:(NSArray *)aViews;
- (NSArray *)constraintsForResizingViews:(NSArray *)aViews;

@end




@implementation M3SplitView {
	NSMutableSet *splitConstraints;
	NSMutableSet *resizeConstraints;
	NSLayoutConstraint *currentConstraint;
	CGFloat currentOffsetToViewEdge;
	NSArray *orderedSubviews;
	NSMutableDictionary *storedConstants;
	BOOL nibLoadingFinished;
}


+ (BOOL)requiresConstraintBasedLayout {
	return YES;
}


#pragma mark -
#pragma mark Setup


- (id)initWithFrame:(CGRect)aFrame {
	if (self = [super initWithFrame:aFrame]) {
		[self setup];
	}
	return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setup];
	}
	return self;
}


- (void)setup {
	splitConstraints = [NSMutableSet set];
	resizeConstraints = [NSMutableSet set];
	_verticalDivider = YES;
	_backgroundColour = [NSColor colorWithCalibratedWhite:0.647 alpha:1.000];
	[self m3_addObserver:self forKeyPathsInArray:@[ @"autosaveName", @"backgroundColour" ] options:0 context:NULL];
}


- (void)awakeFromNib {
	for (NSLayoutConstraint *constraint in self.constraints) {
		if (constraint.firstAttribute == NSLayoutAttributeBottom && !self.hasVerticalDivider) {
			[self removeConstraint:constraint];
		}
		BOOL constraintMatchesAgainstSplitView = (constraint.firstItem == self || constraint.secondItem == self);
		if (constraint.firstAttribute == NSLayoutAttributeLeading && self.hasVerticalDivider && constraintMatchesAgainstSplitView) {
			[self removeConstraint:constraint];
		}
	}
	[self clearSplitConstraints];
	nibLoadingFinished = YES;
}




- (void)viewWillStartLiveResize {
	[super viewWillStartLiveResize];
	
	NSMutableArray *nonResizingViews = [NSMutableArray array];
	NSMutableArray *resizingViews = [NSMutableArray array];
	
	//Get the views to resize and those not to
	[self.orderedSubviews enumerateObjectsUsingBlock:^(NSView *view, NSUInteger index, BOOL *stop) {
		BOOL resizeView = NO;
		if ([self.delegate respondsToSelector:@selector(splitView:shouldFrameChangeResizeSubviewAtIndex:)]) {
			resizeView = [self.delegate splitView:self shouldFrameChangeResizeSubviewAtIndex:index];
		}
		[(resizeView ? resizingViews : nonResizingViews) addObject:view];
	}];
	
	//If we only have non-resizing views, break the last one
	if (nonResizingViews.count == self.orderedSubviews.count) {
		[resizingViews addObject:nonResizingViews.lastObject];
		[nonResizingViews removeLastObject];
	}
		
	//Generate our constraints and add
	[resizeConstraints addObjectsFromArray:[self constraintsForNonResizingViews:nonResizingViews]];
	[resizeConstraints addObjectsFromArray:[self constraintsForResizingViews:resizingViews]];
	[self addConstraints:resizeConstraints.allObjects];
	for (NSLayoutConstraint *constraint in splitConstraints) {
		if (constraint.constant) {
			[constraint setPriority:NSLayoutPriorityWindowSizeStayPut - 1];
		} else {
			[constraint setPriority:NSLayoutPriorityWindowSizeStayPut + 1];
		}
	}
}


- (NSArray *)constraintsForNonResizingViews:(NSArray *)aViews {
	NSMutableArray *returnConstraints = [NSMutableArray array];
	for (NSView *view in aViews) {
		NSLayoutConstraint *constraint = nil;
		if (self.hasVerticalDivider) {
			constraint = [NSLayoutConstraint m3_fixedWidthConstraintWithView:view constant:view.frame.size.width];
		} else {
			constraint = [NSLayoutConstraint m3_fixedHeightConstraintWithView:view constant:view.frame.size.height];
		}
		
		//Make sure our fixed widths are stronger than our split constraints
		[constraint setPriority:NSLayoutPriorityWindowSizeStayPut + 1];
		
		[returnConstraints addObject:constraint];
	}
	return returnConstraints;
}


- (NSArray *)constraintsForResizingViews:(NSArray *)aViews {
	NSMutableArray *returnConstraints = [NSMutableArray array];
	NSMutableArray *resizingViews = [aViews mutableCopy];
	NSView *initialView = resizingViews[0];
	[resizingViews removeObjectAtIndex:0];
	for (NSView *view in resizingViews) {
		CGFloat multiplier = initialView.frame.size.height / view.frame.size.height;
		NSLayoutAttribute attribute = NSLayoutAttributeHeight;
		
		if (self.hasVerticalDivider) {
			attribute = NSLayoutAttributeWidth;
			multiplier = initialView.frame.size.height / view.frame.size.width;
		}
		
		//Keep them in proportion
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:initialView
																	  attribute:attribute
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:view 
																	  attribute:attribute 
																	 multiplier:multiplier
																	   constant:1];
		
		//Make sure our fixed widths are stronger than our split constraints
		[constraint setPriority:NSLayoutPriorityWindowSizeStayPut];
		
		[returnConstraints addObject:constraint];
	}
	return returnConstraints;
}


- (void)viewDidEndLiveResize {
	[super viewDidEndLiveResize];
	[self clearSplitConstraints];
	[self removeConstraints:resizeConstraints.allObjects];
	[resizeConstraints removeAllObjects];
}


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext {
	if ([aKeyPath isEqualToString:@"autosaveName"]) {
		storedConstants = [NSMutableDictionary dictionary];
		if ([self splitViewConstantsKey]) {
			storedConstants = [[[NSUserDefaults standardUserDefaults] objectForKey:self.splitViewConstantsKey] mutableCopy];
		}
		[self clearSplitConstraints];
	} else if ([aKeyPath isEqualToString:@"backgroundColour"]) {
		[self setNeedsDisplay:YES];
	}
}



- (NSView *)subviewAtIndex:(NSInteger)aIndex {
	return self.orderedSubviews[aIndex];
}


- (NSInteger)indexOfSubview:(NSView *)aView {
	return [self.orderedSubviews indexOfObject:aView];
}









- (NSString *)splitViewConstantsKey {
	if (self.autosaveName) {
		return [NSString stringWithFormat:@"M3SplitView %@ Constants", self.autosaveName];
	}
	return nil;
}


- (void)setVerticalDivider:(BOOL)aVertical {
	_verticalDivider = aVertical;
	orderedSubviews = nil;
	[self clearSplitConstraints];
}


- (void)drawRect:(NSRect)dirtyRect {
	[self.backgroundColour set];
	NSRectFill(dirtyRect);
	
	for (NSUInteger i = 0; i < self.numberOfDividers; i++) {
		[self drawDividerInRect:[self rectOfDividerAtIndex:i] vertical:self.hasVerticalDivider];
	}
}


- (void)drawDividerInRect:(NSRect)aRect vertical:(BOOL)aVertical {
	//Only draw the divider if it's bigger than 10 pt (12pt after we modify)
	if ((aVertical && NSWidth(aRect) < 12) || (!aVertical && NSHeight(aRect) < 12))
		return;
	
	[[NSColor colorWithCalibratedWhite:0.647 alpha:1.000] set];
	NSRectFill(aRect);
	
	NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.990 alpha:1.000] 
														 endingColor:[NSColor colorWithCalibratedWhite:0.888 alpha:1.000]];
	
	CGFloat xInset = 0;
	CGFloat yInset = 2;
	CGFloat angle = -90;
	if (aVertical) {
		xInset = 2;
		yInset = 0;
		angle = 0;
	}
	[gradient drawInRect:NSInsetRect(aRect, xInset, yInset) angle:angle];
	
	NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.mcubedsw.M3AppKit"];

	//Lol, knob…
	NSImage *knobImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"M3SplitViewKnob" ofType:@"png"]];
	[knobImage drawInRect:[self rectForKnobImageOfSize:knobImage.size inDividerRect:aRect]
				 fromRect:NSZeroRect 
				operation:NSCompositeSourceOver 
				 fraction:1];
}


 - (NSRect)rectForKnobImageOfSize:(NSSize)aImageSize inDividerRect:(NSRect)aDividerRect {
	CGFloat x = ceil(NSMidX(aDividerRect));
	CGFloat y = ceil(NSMidY(aDividerRect));
	
	return NSMakeRect(x - (aImageSize.width / 2), y - (aImageSize.height / 2), aImageSize.width, aImageSize.height);
}



#pragma mark -
#pragma mark Dividers


- (NSUInteger)numberOfDividers {
	return self.subviews.count - 1;
}


- (NSRect)rectOfDividerAtIndex:(NSInteger)aIndex {
	if (aIndex >= self.numberOfDividers) {
		@throw [NSException exceptionWithName:NSRangeException 
									   reason:@"Supplied index is higher than the number of dividers" 
									 userInfo:nil];
	}
	
	NSArray *orderedViews = self.orderedSubviews;
	NSView *view1 = [orderedViews m3_safeObjectAtIndex:aIndex];
	NSView *view2 = [orderedViews m3_safeObjectAtIndex:aIndex + 1];
	
	NSRect returnRect = self.bounds;
	if (self.hasVerticalDivider) {
		returnRect.origin.x = NSMaxX(view1.frame) - 1;
		returnRect.size.width = NSMinX(view2.frame) - NSMaxX(view1.frame) + 2;
	} else {
		returnRect.origin.y = NSMaxY(view1.frame) - 1;
		returnRect.size.height = NSMinY(view2.frame) - NSMaxY(view1.frame) + 2;
	}
	return returnRect;
}


- (NSInteger)indexOfDividerAtPoint:(NSPoint)aPoint {
	for (NSUInteger i = 0; i < self.numberOfDividers; i++) {
		if (NSPointInRect(aPoint, [self rectOfDividerAtIndex:i])) {
			return i;
		}
	}
	return -1;
}





#pragma mark -
#pragma mark Subviews


- (NSArray *)orderedSubviews {
	if (!orderedSubviews) {
		orderedSubviews = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(NSView *obj1, NSView *obj2) {
			CGFloat view1Value = obj1.frame.origin.y;
			CGFloat view2Value = obj2.frame.origin.y;
			 
			if (self.hasVerticalDivider) {
				view1Value = obj1.frame.origin.x;
				view2Value = obj2.frame.origin.x;
			}
			
			if (view1Value < view2Value) {
				return NSOrderedAscending;
			}
			if (view1Value > view2Value) {
				return NSOrderedDescending;
			}
			return NSOrderedSame;
		}];
	}
	return orderedSubviews;
}


- (void)addSubview:(NSView *)aView {
	[super addSubview:aView];
	orderedSubviews = nil;
	
	if (nibLoadingFinished) {
		[self clearSplitConstraints];
	}
}





#pragma mark -
#pragma mark Constraints


- (NSLayoutConstraint *)constraintForView:(NSView *)aView {
	for (NSLayoutConstraint *constraint in splitConstraints) {
		if ([constraint.firstItem isEqual:aView]) {
			return constraint;
		}
	}
	
	NSLayoutAttribute attribute = NSLayoutAttributeBottom;
	if (self.hasVerticalDivider) {
		attribute = NSLayoutAttributeLeading;
	}
	
	CGFloat initialValue = -aView.frame.origin.y;
	if (self.hasVerticalDivider) {
		initialValue = aView.frame.origin.x;
	}
	
	NSInteger index = [self indexOfSubview:aView];
	if (storedConstants[[NSString stringWithFormat:@"%ld",index]]) {
		initialValue = [storedConstants[[NSString stringWithFormat:@"%ld",index]] floatValue];
	}
	
	
	NSLayoutConstraint *returnConstraint = [NSLayoutConstraint constraintWithItem:aView 
																		attribute:attribute 
																		relatedBy:NSLayoutRelationEqual 
																		   toItem:self 
																		attribute:attribute 
																	   multiplier:1 
																		 constant:initialValue];
	
	[returnConstraint setPriority:NSLayoutPriorityDragThatCannotResizeWindow];
	[splitConstraints addObject:returnConstraint];
	
	return returnConstraint;
}


- (void)clearSplitConstraints {
	[self removeConstraints:splitConstraints.allObjects];
	splitConstraints = [NSMutableSet set];
	for (NSView *subview in self.subviews) {
		[self addConstraint:[self constraintForView:subview]];
	}
}





#pragma mark -
#pragma mark Mouse handling


- (void)mouseDown:(NSEvent *)aEvent {
	NSPoint mousePoint = [self convertPoint:aEvent.locationInWindow fromView:nil];
	NSInteger index = [self indexOfDividerAtPoint:mousePoint];
	
	if (index == -1) return;
	
	NSView *view = self.orderedSubviews[index + 1];
	currentConstraint = [self constraintForView:view];
	[currentConstraint setPriority:NSLayoutPriorityDragThatCannotResizeWindow - 1];
	if (self.hasVerticalDivider) {
		currentOffsetToViewEdge = NSMinX(view.frame) - mousePoint.x;
	} else {
		currentOffsetToViewEdge = NSMinY(view.frame) - mousePoint.y;
	}
	[self.window disableCursorRects];
}


- (void)mouseDragged:(NSEvent *)aEvent {
	NSPoint mousePoint = [self convertPoint:aEvent.locationInWindow fromView:nil];
	if (self.hasVerticalDivider) {
		[currentConstraint setConstant:mousePoint.x + currentOffsetToViewEdge];
	} else {
		[currentConstraint setConstant:-mousePoint.y - currentOffsetToViewEdge];
	}
	[self setNeedsDisplay:YES];
}


- (void)mouseUp:(NSEvent *)aEvent {
	NSInteger index = [self.orderedSubviews indexOfObject:currentConstraint.firstItem];
	storedConstants[[NSString stringWithFormat:@"%ld",index]] = [NSNumber numberWithFloat:currentConstraint.constant];
	if (self.splitViewConstantsKey) {
		[[NSUserDefaults standardUserDefaults] setObject:storedConstants forKey:self.splitViewConstantsKey];
	}
	[currentConstraint setPriority:NSLayoutPriorityDragThatCannotResizeWindow];
	currentConstraint = nil;
	currentOffsetToViewEdge = 0;
	[self resetCursorRects];
	[self.window enableCursorRects];
}


- (void)resetCursorRects {
	for (NSUInteger i = 0; i < self.numberOfDividers; i++) {
		NSRect dividerRect = [self rectOfDividerAtIndex:i];
		if (self.hasVerticalDivider) {
			[self addCursorRect:dividerRect cursor:[NSCursor resizeLeftRightCursor]];
		} else {
			[self addCursorRect:dividerRect cursor:[NSCursor resizeUpDownCursor]];
		}
	}
}


- (NSView *)hitTest:(NSPoint)aPoint {
	if ([self indexOfDividerAtPoint:aPoint] != -1) {
		return self;
	}
	return [super hitTest:aPoint];
}

@end
