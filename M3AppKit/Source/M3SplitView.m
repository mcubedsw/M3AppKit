//
//  M3SplitView.m
//  M3ConstraintBasedSplitView
//
//  Created by Martin Pilkington on 19/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "M3SplitView.h"
#import "NSLayoutConstraint+M3Extensions.h"

@interface M3SplitView () 

- (void)_setup;

- (NSUInteger)_numberOfDividers;
- (NSRect)_rectOfDividerAtIndex:(NSInteger)aIndex;
- (NSInteger)_indexOfDividerAtPoint:(NSPoint)aPoint;

- (NSArray *)_orderedSubviews;

- (NSLayoutConstraint *)_constraintForView:(NSView *)aView;
- (void)_clearSplitConstraints;

- (NSString *)_splitViewConstantsKey;

- (NSRect)_rectForKnobImageOfSize:(NSSize)aImageSize inDividerRect:(NSRect)aDividerRect;

- (NSArray *)_constraintsForNonResizingViews:(NSArray *)aViews;
- (NSArray *)_constraintsForResizingViews:(NSArray *)aViews;

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

@synthesize verticalDivider, autosaveName, delegate, backgroundColour;

+ (BOOL)requiresConstraintBasedLayout {
	return YES;
}

/***************************
 
 **************************/
- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self _setup];
	}
	return self;
}

/***************************
 
 **************************/
- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self _setup];
	}
	return self;
}

/***************************
 
 **************************/
- (void)_setup {
	splitConstraints = [NSMutableSet set];
	resizeConstraints = [NSMutableSet set];
	verticalDivider = YES;
	backgroundColour = [NSColor colorWithCalibratedWhite:0.647 alpha:1.000];
	[self m3_addObserver:self forKeyPathsInArray:[NSArray arrayWithObjects:@"autosaveName", @"backgroundColour", nil] options:0 context:NULL];
}

/***************************
 
 **************************/
- (void)awakeFromNib {
	for (NSLayoutConstraint *constraint in [self constraints]) {
		if ([constraint firstAttribute] == NSLayoutAttributeBottom && ![self hasVerticalDivider]) {
			[self removeConstraint:constraint];
		}
		if ([constraint firstAttribute] == NSLayoutAttributeLeading && [self hasVerticalDivider] &&
			([constraint firstItem] == self || [constraint secondItem] == self)) {
			[self removeConstraint:constraint];
		}
	}
	[self _clearSplitConstraints];
	nibLoadingFinished = YES;
	
}



/***************************
 
 **************************/
- (void)viewWillStartLiveResize {
	[super viewWillStartLiveResize];
	
	NSMutableArray *nonResizingViews = [NSMutableArray array];
	NSMutableArray *resizingViews = [NSMutableArray array];
	
	//Get the views to resize and those not to
	[[self _orderedSubviews] enumerateObjectsUsingBlock:^(NSView *view, NSUInteger index, BOOL *stop) {
		BOOL resizeView = NO;
		if ([[self delegate] respondsToSelector:@selector(splitView:shouldFrameChangeResizeSubviewAtIndex:)]) {
			resizeView = [[self delegate] splitView:self shouldFrameChangeResizeSubviewAtIndex:index];
		}
		[(resizeView ? resizingViews : nonResizingViews) addObject:view];
	}];
	
	//If we only have non-resizing views, break the last one
	if ([nonResizingViews count] == [[self _orderedSubviews] count]) {
		[resizingViews addObject:[nonResizingViews lastObject]];
		[nonResizingViews removeLastObject];
	}
		
	//Generate our constraints and add
	[resizeConstraints addObjectsFromArray:[self _constraintsForNonResizingViews:nonResizingViews]];
	[resizeConstraints addObjectsFromArray:[self _constraintsForResizingViews:resizingViews]];
	[self addConstraints:[resizeConstraints allObjects]];
	for (NSLayoutConstraint *constraint in splitConstraints) {
		NSLog(@"%@", constraint);
		if ([constraint constant]) {
			[constraint setPriority:NSLayoutPriorityWindowSizeStayPut - 1];
		} else {
			[constraint setPriority:NSLayoutPriorityWindowSizeStayPut + 1];
		}
	}
}

/***************************
 
 **************************/
- (NSArray *)_constraintsForNonResizingViews:(NSArray *)aViews {
	NSMutableArray *returnConstraints = [NSMutableArray array];
	for (NSView *view in aViews) {
		NSLayoutConstraint *constraint = nil;
		if ([self hasVerticalDivider]) {
			constraint = [NSLayoutConstraint m3_fixedWidthConstraintWithView:view constant:[view frame].size.width];
		} else {
			constraint = [NSLayoutConstraint m3_fixedHeightConstraintWithView:view constant:[view frame].size.height];
		}
		
		//Make sure our fixed widths are stronger than our split constraints
		[constraint setPriority:NSLayoutPriorityWindowSizeStayPut + 1];
		
		[returnConstraints addObject:constraint];
	}
	return returnConstraints;
}

/***************************
 
 **************************/
- (NSArray *)_constraintsForResizingViews:(NSArray *)aViews {
	NSMutableArray *returnConstraints = [NSMutableArray array];
	NSMutableArray *resizingViews = [aViews mutableCopy];
	NSView *initialView = [resizingViews objectAtIndex:0];
	[resizingViews removeObjectAtIndex:0];
	for (NSView *view in resizingViews) {
		CGFloat multiplier = [initialView frame].size.height / [view frame].size.height;
		NSLayoutAttribute attribute = NSLayoutAttributeHeight;
		
		if ([self hasVerticalDivider]) {
			attribute = NSLayoutAttributeWidth;
			multiplier = [initialView frame].size.height / [view frame].size.width;
		}
		
		//Keep them in proportion
		NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:initialView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:multiplier constant:1];
		
		//Make sure our fixed widths are stronger than our split constraints
		[constraint setPriority:NSLayoutPriorityWindowSizeStayPut];
		
		[returnConstraints addObject:constraint];
	}
	return returnConstraints;
}

/***************************
 
 **************************/
- (void)viewDidEndLiveResize {
	[super viewDidEndLiveResize];
	[self _clearSplitConstraints];
	[self removeConstraints:[resizeConstraints allObjects]];
	[resizeConstraints removeAllObjects];
}

/***************************
 
 **************************/
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"autosaveName"]) {
		storedConstants = [NSMutableDictionary dictionary];
		if ([self _splitViewConstantsKey]) {
			storedConstants = [[[NSUserDefaults standardUserDefaults] objectForKey:[self _splitViewConstantsKey]] mutableCopy];
		}
		[self _clearSplitConstraints];
	} else if ([keyPath isEqualToString:@"backgroundColour"]) {
		[self setNeedsDisplay:YES];
	}
}


- (NSView *)subviewAtIndex:(NSInteger)aIndex {
	return [[self _orderedSubviews] objectAtIndex:aIndex];
}

- (NSInteger)indexOfSubview:(NSView *)aView {
	return [[self _orderedSubviews] indexOfObject:aView];
}








/***************************
 
 **************************/
- (NSString *)_splitViewConstantsKey {
	if ([self autosaveName]) {
		return [NSString stringWithFormat:@"M3SplitView %@ Constants", [self autosaveName]];
	}
	return nil;
}

/***************************
 
 **************************/
- (void)setVerticalDivider:(BOOL)aVertical {
	verticalDivider = aVertical;
	orderedSubviews = nil;
	[self _clearSplitConstraints];
}

/***************************
 
 **************************/
- (void)drawRect:(NSRect)dirtyRect {
	[[self backgroundColour] set];
	NSRectFill(dirtyRect);
	
	for (NSUInteger i = 0; i < [self _numberOfDividers]; i++) {
		[self drawDividerInRect:[self _rectOfDividerAtIndex:i] vertical:[self hasVerticalDivider]];
	}
}

/***************************
 
 **************************/
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
#ifdef M3APPKIT_IB_BUILD
	bundle = [NSBundle bundleWithIdentifier:@"com.mcubedsw.M3AppKitIB"];
#endif
	
	NSImage *knobImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"M3SplitViewKnob" ofType:@"png"]];
	[knobImage drawInRect:[self _rectForKnobImageOfSize:[knobImage size] inDividerRect:aRect] 
				 fromRect:NSZeroRect 
				operation:NSCompositeSourceOver 
				 fraction:1];
}

/***************************
 
 **************************/
 - (NSRect)_rectForKnobImageOfSize:(NSSize)aImageSize inDividerRect:(NSRect)aDividerRect {
	CGFloat x = ceil(NSMidX(aDividerRect));
	CGFloat y = ceil(NSMidY(aDividerRect));
	
	return NSMakeRect(x - (aImageSize.width / 2), y - (aImageSize.height / 2), aImageSize.width, aImageSize.height);
}



#pragma mark -
#pragma mark Dividers

/***************************
 
 **************************/
- (NSUInteger)_numberOfDividers {
	return [[self subviews] count] - 1;
}

/***************************
 
 **************************/
- (NSRect)_rectOfDividerAtIndex:(NSInteger)aIndex {
	if (aIndex >= [self _numberOfDividers])
		@throw [NSException exceptionWithName:NSRangeException 
									   reason:@"Supplied index is higher than the number of dividers" 
									 userInfo:nil];
	
	NSArray *orderedViews = [self _orderedSubviews];
	NSView *view1 = [orderedViews m3_safeObjectAtIndex:aIndex];
	NSView *view2 = [orderedViews m3_safeObjectAtIndex:aIndex + 1];
	
	NSRect returnRect = [self bounds];
	if ([self hasVerticalDivider]) {
		returnRect.origin.x = NSMaxX([view1 frame]) - 1;
		returnRect.size.width = NSMinX([view2 frame]) - NSMaxX([view1 frame]) + 2;
	} else {
		returnRect.origin.y = NSMaxY([view1 frame]) - 1;
		returnRect.size.height = NSMinY([view2 frame]) - NSMaxY([view1 frame]) + 2; 
	}
	return returnRect;
}

/***************************
 
 **************************/
- (NSInteger)_indexOfDividerAtPoint:(NSPoint)aPoint {
	for (NSUInteger i = 0; i < [self _numberOfDividers]; i++) {
		if (NSPointInRect(aPoint, [self _rectOfDividerAtIndex:i]))
			return i;
	}
	return -1;
}





#pragma mark -
#pragma mark Subviews

/***************************
 
 **************************/
- (NSArray *)_orderedSubviews {
	if (!orderedSubviews) {
		orderedSubviews = [[self subviews] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			CGFloat view1Value = 0;
			CGFloat view2Value = 0;
			if ([self hasVerticalDivider]) {
				view1Value = [obj1 frame].origin.x;
				view2Value = [obj2 frame].origin.x;
			} else {
				view1Value = [obj1 frame].origin.y;
				view2Value = [obj2 frame].origin.y;
			}
			
			if (view1Value < view2Value)
				return NSOrderedAscending;
			if (view1Value > view2Value)
				return NSOrderedDescending;
			return NSOrderedSame;
		}];
	}
	return orderedSubviews;
}

/***************************
 
 **************************/
- (void)addSubview:(NSView *)aView {
	[super addSubview:aView];
	orderedSubviews = nil;
	
	if (nibLoadingFinished) {
		[self _clearSplitConstraints];
	}
}





#pragma mark -
#pragma mark Constraints

/***************************
 
 **************************/
- (NSLayoutConstraint *)_constraintForView:(NSView *)aView {
	for (NSLayoutConstraint *constraint in splitConstraints) {
		if ([[constraint firstItem] isEqual:aView]) 
			return constraint;
	}
	
	NSLayoutAttribute attribute = NSLayoutAttributeBottom;
	if ([self hasVerticalDivider]) {
		attribute = NSLayoutAttributeLeading;
	}
	
	CGFloat initialValue = -[aView frame].origin.y;
	if ([self hasVerticalDivider]) {
		initialValue = [aView frame].origin.x;
	}
	
	NSInteger index = [[self _orderedSubviews] indexOfObject:aView];
	if ([storedConstants objectForKey:[NSString stringWithFormat:@"%ld",index]]) {
		initialValue = [[storedConstants objectForKey:[NSString stringWithFormat:@"%ld",index]] floatValue];
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

/***************************
 
 **************************/
- (void)_clearSplitConstraints {
	[self removeConstraints:[splitConstraints allObjects]];
	splitConstraints = [NSMutableSet set];
	for (NSView *subview in [self subviews]) {
		[self addConstraint:[self _constraintForView:subview]];
	}
}





#pragma mark -
#pragma mark Mouse handling

/***************************
 
 **************************/
- (void)mouseDown:(NSEvent *)theEvent {
	NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSInteger index = [self _indexOfDividerAtPoint:mousePoint];
	if (index == -1)
		return;
	
	NSView *view = [[self _orderedSubviews] objectAtIndex:index + 1];
	currentConstraint = [self _constraintForView:view];
	[currentConstraint setPriority:NSLayoutPriorityDragThatCannotResizeWindow - 1];
	if ([self hasVerticalDivider]) {
		currentOffsetToViewEdge = NSMinX([view frame]) - mousePoint.x;
	} else {
		currentOffsetToViewEdge = NSMinY([view frame]) - mousePoint.y;
	}
	[[self window] disableCursorRects];
}

/***************************
 
 **************************/
- (void)mouseDragged:(NSEvent *)theEvent {
	NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	if ([self hasVerticalDivider]) {
		[currentConstraint setConstant:mousePoint.x + currentOffsetToViewEdge];
	} else {
		[currentConstraint setConstant:-mousePoint.y - currentOffsetToViewEdge];
	}
	[self setNeedsDisplay:YES];
}

/***************************
 
 **************************/
- (void)mouseUp:(NSEvent *)theEvent {
	NSInteger index = [[self _orderedSubviews] indexOfObject:[currentConstraint firstItem]];
	[storedConstants setObject:[NSNumber numberWithFloat:[currentConstraint constant]] 
						forKey:[NSString stringWithFormat:@"%ld",index]];
	if ([self _splitViewConstantsKey]) {
		[[NSUserDefaults standardUserDefaults] setObject:storedConstants forKey:[self _splitViewConstantsKey]];
	}
	[currentConstraint setPriority:NSLayoutPriorityDragThatCannotResizeWindow];
	currentConstraint = nil;
	currentOffsetToViewEdge = 0;
	[self resetCursorRects];
	[[self window] enableCursorRects];
}

/***************************
 
 **************************/
- (void)resetCursorRects {
	for (NSUInteger i = 0; i < [self _numberOfDividers]; i++) {
		NSRect dividerRect = [self _rectOfDividerAtIndex:i];
		if ([self hasVerticalDivider]) {
			[self addCursorRect:dividerRect cursor:[NSCursor resizeLeftRightCursor]];
		} else {
			[self addCursorRect:dividerRect cursor:[NSCursor resizeUpDownCursor]];
		}
	}
}

/***************************
 
 **************************/
- (NSView *)hitTest:(NSPoint)aPoint {
	if ([self _indexOfDividerAtPoint:aPoint] != -1)
		return self;
	return [super hitTest:aPoint];
}

@end
