/*****************************************************************
 M3PreferencesWindow.m
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3PreferencesWindow.h"
#import "M3PreferencesSection.h"
#import "NSView+M3Extensions.h"

@interface M3PreferencesWindow () 

- (void)p_reloadViews;
- (NSToolbar *)p_prefsToolbar;
- (NSArray *)p_toolbarItems;
- (void)p_toolbarItemClicked:(id)aSender;
- (void)p_displayItemAtIndex:(NSUInteger)aIndex animated:(BOOL)aAnimated;

@end


@implementation M3PreferencesWindow {
	NSToolbar *prefsToolbar;
	NSArray *toolbarItems;
	__weak id<M3PreferencesSection> currentSection;
}

//*****//
- (id)initWithContentRect:(NSRect)aContentRect styleMask:(NSUInteger)aWindowStyle backing:(NSBackingStoreType)aBufferingType defer:(BOOL)aDeferCreation {
    if ((self = [super initWithContentRect:aContentRect styleMask:aWindowStyle backing:aBufferingType defer:aDeferCreation])) {
        [self addObserver:self forKeyPath:@"sections" options:0 context:NULL];
		[self setToolbar:self.p_prefsToolbar];
		[self setShowsToolbarButton:NO];
    }
    
    return self;
}

//*****//
- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext {
	if ([aKeyPath isEqualToString:@"sections"]) {
		[self p_reloadViews];
		[self.p_prefsToolbar setSelectedItemIdentifier:[[self.p_toolbarItems m3_safeObjectAtIndex:0] itemIdentifier]];
	} else {
		[super observeValueForKeyPath:aKeyPath ofObject:aObject change:aChange context:aContext];
	}
}

//*****//
- (void)keyDown:(NSEvent *)aEvent {
	if (aEvent.keyCode == 53) {
		[self close];
	}
}





#pragma mark -
#pragma mark Toolbars

//*****//
- (NSToolbar *)p_prefsToolbar {
	if (!prefsToolbar) {
		prefsToolbar = [[NSToolbar alloc] initWithIdentifier:@"com.mcubedsw.m3prefswindow"];
		[prefsToolbar setAllowsUserCustomization:NO];
		[prefsToolbar setDelegate:self];
	}
	return prefsToolbar;
}

//*****//
- (NSArray *)p_toolbarItems {
	if (!toolbarItems) {
		NSMutableArray *items = [NSMutableArray array];
		for (id<M3PreferencesSection> section in self.sections) {
			NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:[NSString stringWithFormat:@"com.mcubedsw.m3prefswindow.%@", section.title]];
			[item setLabel:section.title];
			[item setImage:section.image];
			[item setTarget:self];
			[item setAction:@selector(p_toolbarItemClicked:)];
			[items addObject:item];
		}
		toolbarItems = [items copy];
	}
	return toolbarItems;
}

//*****//
- (void)p_reloadViews {
	toolbarItems = nil;
	while (self.p_prefsToolbar.items.count) {
		[self.p_prefsToolbar removeItemAtIndex:0];
	}
	
	for (NSString *ident in [self.p_toolbarItems valueForKey:@"itemIdentifier"]) {
		[self.p_prefsToolbar insertItemWithItemIdentifier:ident atIndex:self.p_prefsToolbar.items.count];
	}
	[self p_displayItemAtIndex:0 animated:NO];
}





#pragma mark -
#pragma mark Toolbar delegate

//*****//
- (NSToolbarItem *)toolbar:(NSToolbar *)aToolbar itemForItemIdentifier:(NSString *)aItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag {
	for (NSToolbarItem *item in self.p_toolbarItems) {
		if ([aItemIdentifier isEqualToString:item.itemIdentifier]) {
			return item;
		}
	}
	return nil;
}

//*****//
- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)aToolbar {
	return [self.p_toolbarItems valueForKey:@"itemIdentifier"];
}

//*****//
- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)aToolbar {
	return [self.p_toolbarItems valueForKey:@"itemIdentifier"];
}

//*****//
- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)aToolbar {
	return [self.p_toolbarItems valueForKey:@"itemIdentifier"];
}

//*****//
- (void)p_toolbarItemClicked:(id)aSender {
	[self p_displayItemAtIndex:[self. p_toolbarItems indexOfObject:aSender] animated:YES];
}

//*****//
- (void)p_displayItemAtIndex:(NSUInteger)aIndex animated:(BOOL)aAnimated {
	id<M3PreferencesSection> newSection = self.sections[aIndex];
	[self setTitle:newSection.title];
	
	[newSection view];
	
	if ([newSection respondsToSelector:@selector(sectionWillDisplay)]) {
		[newSection sectionWillDisplay];
	}
	
	if (currentSection) {
		[currentSection.view removeFromSuperview];
		[self.contentView m3_addSubview:newSection.view andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0) animated:YES];
	} else {
		[[self.contentView animator] m3_addSubview:newSection.view andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0)];
	}
	
	
	currentSection = newSection;
}

@end
