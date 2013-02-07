/*****************************************************************
 M3PreferencesWindow.m
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3PreferencesWindow.h"

#import "M3PreferencesSection.h"
#import "NSView+M3Extensions.h"

#define ESCAPE_KEY_CODE 53


@implementation M3PreferencesWindow {
	NSToolbar *preferencesToolbar;
	NSArray *toolbarItems;
	__weak id<M3PreferencesSection> currentSection;
}


- (id)initWithContentRect:(NSRect)aContentRect styleMask:(NSUInteger)aWindowStyle backing:(NSBackingStoreType)aBufferingType defer:(BOOL)aDeferCreation {
    if ((self = [super initWithContentRect:aContentRect styleMask:aWindowStyle backing:aBufferingType defer:aDeferCreation])) {
        [self addObserver:self forKeyPath:@"sections" options:0 context:NULL];
		[self setToolbar:self.preferencesToolbar];
		[self setShowsToolbarButton:NO];
    }
    
    return self;
}


- (void)observeValueForKeyPath:(NSString *)aKeyPath ofObject:(id)aObject change:(NSDictionary *)aChange context:(void *)aContext {
	if ([aKeyPath isEqualToString:@"sections"]) {
		[self reloadViews];
		[self.preferencesToolbar setSelectedItemIdentifier:[[self.toolbarItems m3_safeObjectAtIndex:0] itemIdentifier]];
	} else {
		[super observeValueForKeyPath:aKeyPath ofObject:aObject change:aChange context:aContext];
	}
}


- (void)keyDown:(NSEvent *)aEvent {
	if (aEvent.keyCode == ESCAPE_KEY_CODE) [self close];
}





#pragma mark -
#pragma mark Toolbars


- (NSToolbar *)preferencesToolbar {
	if (!preferencesToolbar) {
		preferencesToolbar = [[NSToolbar alloc] initWithIdentifier:@"com.mcubedsw.m3prefswindow"];
		[preferencesToolbar setAllowsUserCustomization:NO];
		[preferencesToolbar setDelegate:self];
	}
	return preferencesToolbar;
}


- (NSArray *)toolbarItems {
	if (!toolbarItems) {
		NSMutableArray *items = [NSMutableArray array];
		for (id<M3PreferencesSection> section in self.sections) {
			NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:[NSString stringWithFormat:@"com.mcubedsw.m3prefswindow.%@", section.title]];
			[item setLabel:section.title];
			[item setImage:section.image];
			[item setTarget:self];
			[item setAction:@selector(toolbarItemClicked:)];
			[items addObject:item];
		}
		toolbarItems = [items copy];
	}
	return toolbarItems;
}





#pragma mark -
#pragma mark Toolbar delegate


- (NSToolbarItem *)toolbar:(NSToolbar *)aToolbar itemForItemIdentifier:(NSString *)aItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag {
	for (NSToolbarItem *item in self.toolbarItems) {
		if ([aItemIdentifier isEqualToString:item.itemIdentifier]) {
			return item;
		}
	}
	return nil;
}


- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)aToolbar {
	return [self.toolbarItems valueForKey:@"itemIdentifier"];
}


- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)aToolbar {
	return [self.toolbarItems valueForKey:@"itemIdentifier"];
}


- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)aToolbar {
	return [self.toolbarItems valueForKey:@"itemIdentifier"];
}


- (void)toolbarItemClicked:(id)aSender {
	[self displayItemAtIndex:[self. toolbarItems indexOfObject:aSender] animated:YES];
}





#pragma mark -
#pragma mark Displaying Views


- (void)reloadViews {
	toolbarItems = nil;
	while (self.preferencesToolbar.items.count) {
		[self.preferencesToolbar removeItemAtIndex:0];
	}
	
	for (NSString *ident in [self.toolbarItems valueForKey:@"itemIdentifier"]) {
		[self.preferencesToolbar insertItemWithItemIdentifier:ident atIndex:self.preferencesToolbar.items.count];
	}
	[self displayItemAtIndex:0 animated:NO];
}


- (void)displayItemAtIndex:(NSUInteger)aIndex animated:(BOOL)aAnimated {
	id<M3PreferencesSection> newSection = self.sections[aIndex];
	[self setTitle:newSection.title];
	
	[newSection view];
	
	if ([newSection respondsToSelector:@selector(sectionWillDisplay)]) {
		[newSection sectionWillDisplay];
	}
	
#warning Fix transition
	if (currentSection) {
		[currentSection.view removeFromSuperview];
		[self.contentView m3_addSubview:newSection.view andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0) animated:YES];
	} else {
		[[self.contentView animator] m3_addSubview:newSection.view andFillConstraintsWithInset:NSEdgeInsetsMake(0, 0, 0, 0)];
	}
	
	
	currentSection = newSection;
}

@end
