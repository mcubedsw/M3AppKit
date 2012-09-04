//
//  M3TestContentView.m
//  M3AppKit
//
//  Created by Martin Pilkington on 03/09/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3TestContentView.h"

@implementation M3TestContentView

- (void)setContentView:(NSView *)aContentView {
	_contentView = aContentView;
	[self addSubview:aContentView];
}

@end
