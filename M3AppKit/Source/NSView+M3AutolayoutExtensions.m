/*****************************************************************
 NSView+M3AutolayoutExtensions.m
 M3AppKit
 
 Created by Martin Pilkington on 01/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSView+M3AutolayoutExtensions.h"

#import "M3ConstraintStringParser.h"

@implementation NSView (M3AutolayoutExtensions)

- (void)m3_addSubview:(NSView *)aSubview marginsToSuperview:(NSEdgeInsets)aInsets {
	[aSubview setTranslatesAutoresizingMaskIntoConstraints:NO];
	[self addSubview:aSubview];
	
	NSDictionary *subviewDict = NSDictionaryOfVariableBindings(aSubview);
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-(%f)-[aSubview]-(%f)-|", aInsets.left, aInsets.right] options:0 metrics:nil views:subviewDict]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(%f)-[aSubview]-(%f)-|", aInsets.top, aInsets.bottom] options:0 metrics:nil views:subviewDict]];
}


- (void)m3_addConstraintsFromEquations:(NSArray *)aConstraints substitutionViews:(id)aSubstitutionViews {
	NSDictionary *substitutionViews = M3SubstitutionViewsWithCollection(aSubstitutionViews, self);
	M3ConstraintStringParser *parser = [[M3ConstraintStringParser alloc] initWithSubstitutionViews:substitutionViews];
	for (NSString *constraint in aConstraints) {
		[self addConstraints:[parser constraintsFromString:constraint]];
	}
}

@end
