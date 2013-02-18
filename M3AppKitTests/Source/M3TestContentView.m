/*****************************************************************
 M3TestContentView.m
 M3AppKit
 
 Created by Martin Pilkington on 03/09/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3TestContentView.h"

@implementation M3TestContentView

- (void)setContentView:(NSView *)aContentView {
	_contentView = aContentView;
	[self addSubview:aContentView];
}

@end
