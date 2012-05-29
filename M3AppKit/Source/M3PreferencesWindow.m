//
//  M3PreferencesWindow.m
//  Code Collector
//
//  Created by Martin Pilkington on 15/01/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "M3PreferencesWindow.h"
#import "M3PreferencesSection.h"
#import "NSView+M3Extensions.h"

@interface M3PreferencesWindow () {
	NSToolbar *prefsToolbar;
	NSArray *toolbarItems;
	__weak id<M3PreferencesSection> currentSection;
}

- (void)_reloadViews;
- (NSToolbar *)_prefsToolbar;
- (NSArray *)_toolbarItems;
- (void)_toolbarItemClicked:(id)sender;
- (void)_displayItemAtIndex:(NSUInteger)aIndex animated:(BOOL)aAnimated;

@end


@implementation M3PreferencesWindow

@synthesize sections;

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation {
    if ((self = [super initWithContentRect:contentRect styleMask:windowStyle backing:bufferingType defer:deferCreation])) {
        [self addObserver:self forKeyPath:@"sections" options:0 context:NULL];
		[self setToolbar:[self _prefsToolbar]];
		[self setShowsToolbarButton:NO];
    }
    
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"sections"]) {
		[self _reloadViews];
		[[self _prefsToolbar] setSelectedItemIdentifier:[[[self _toolbarItems] m3_safeObjectAtIndex:0] itemIdentifier]];
	} else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

- (void)keyDown:(NSEvent *)theEvent {
	if ([theEvent keyCode] == 53) {
		[self close];
	}
}





#pragma mark -
#pragma mark Toolbars

- (NSToolbar *)_prefsToolbar {
	if (!prefsToolbar) {
		prefsToolbar = [[NSToolbar alloc] initWithIdentifier:@"com.mcubedsw.m3prefswindow"];
		[prefsToolbar setAllowsUserCustomization:NO];
		[prefsToolbar setDelegate:self];
	}
	return prefsToolbar;
}

- (NSArray *)_toolbarItems {
	if (!toolbarItems) {
		NSMutableArray *items = [NSMutableArray array];
		for (id<M3PreferencesSection> section in sections) {
			NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:[NSString stringWithFormat:@"com.mcubedsw.m3prefswindow.%@", [section title]]];
			[item setLabel:[section title]];
			[item setImage:[section image]];
			[item setTarget:self];
			[item setAction:@selector(_toolbarItemClicked:)];
			[items addObject:item];
		}
		toolbarItems = [items copy];
	}
	return toolbarItems;
}

- (void)_reloadViews {
	toolbarItems = nil;
	while ([[[self _prefsToolbar] items] count]) {
		[[self _prefsToolbar] removeItemAtIndex:0];
	}
	
	for (NSString *ident in [[self _toolbarItems] valueForKey:@"itemIdentifier"]) {
		[[self _prefsToolbar] insertItemWithItemIdentifier:ident atIndex:[[[self _prefsToolbar] items] count]];
	}
	[self _displayItemAtIndex:0 animated:NO];
}






#pragma mark -
#pragma mark Toolbar delegate

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
	for (NSToolbarItem *item in [self _toolbarItems]) {
		if ([itemIdentifier isEqualToString:[item itemIdentifier]]) {
			return item;
		}
	}
	return nil;
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
	return [[self _toolbarItems] valueForKey:@"itemIdentifier"];
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
	return [[self _toolbarItems] valueForKey:@"itemIdentifier"];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
	return [[self _toolbarItems] valueForKey:@"itemIdentifier"];
}



- (void)_toolbarItemClicked:(id)sender {
	[self _displayItemAtIndex:[[self _toolbarItems] indexOfObject:sender] animated:YES];
}


- (void)_displayItemAtIndex:(NSUInteger)aIndex animated:(BOOL)aAnimated {
	id<M3PreferencesSection> newSection = [[self sections] objectAtIndex:aIndex];
	[self setTitle:[newSection title]];
	
	[newSection view];
	
	if ([newSection respondsToSelector:@selector(sectionWillDisplay)]) {
		[newSection sectionWillDisplay];
	}
	
	if (currentSection) {
		[[currentSection view] removeFromSuperview];
		[[self contentView] m3_addSubview:[newSection view] andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0) animated:YES];
	} else {
		[[[self contentView] animator] m3_addSubview:[newSection view] andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0)];
	}
	
	
	currentSection = newSection;
	
	/*CGFloat newY = [[self contentView] frame].size.height - [[section view] frame].size.height;
	[[section view] setFrameOrigin:NSMakePoint(0, newY)];
	[[self contentView] addSubview:[section view]];
	
	NSRect windowFrame = [[section view] frame];
	windowFrame.size.height += 98;
	windowFrame.origin = [self frame].origin;
	windowFrame.origin.y = windowFrame.origin.y - (windowFrame.size.height - [self frame].size.height);
	
	[self setFrame:windowFrame display:YES animate:aAnimated];*/
}

@end
