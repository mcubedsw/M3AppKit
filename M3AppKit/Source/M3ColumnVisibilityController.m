/*****************************************************************
 M3ColumnVisibilityController.m
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ColumnVisibilityController.h"


@implementation M3ColumnVisibilityController

@synthesize tableView, ignoredColumnIdentifiers;

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		[self setTableView:[aDecoder decodeObjectForKey:@"tableView"]];
	}
	return self;
}

- (id)init {
	if ((self = [super init])) {
		[self addObserver:self forKeyPath:@"ignoredColumnIdentifiers" options:0 context:NULL];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeConditionalObject:tableView forKey:@"tableView"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	menu = nil;
	[[[self tableView] headerView] setMenu:[self menu]];
}

- (void)setTableView:(NSTableView *)view {
	if (tableView != view) {
		tableView = view;
		menu = nil;
		[[tableView headerView] setMenu:[self menu]];
	}
}

- (NSMenu *)menu {
	if (!menu) {
		menu = [[NSMenu alloc] init];
		for (NSTableColumn *column in [tableView tableColumns]) {
			if ([[self ignoredColumnIdentifiers] containsObject:[column identifier]])
				continue;
			
			NSMenuItem *item = [[NSMenuItem alloc] init];
			[item setTitle:[[column headerCell] stringValue]];
			[item setRepresentedObject:column];
			[item setTarget:self];
			[item setAction:@selector(toggleColumn:)];
			[item setState:![column isHidden]];
			[menu addItem:item];
		}
	}
	return menu;
}

- (void)toggleColumn:(id)sender {
	[[sender representedObject] setHidden:![[sender representedObject] isHidden]];
	[sender setState:![[sender representedObject] isHidden]];
}

@end
