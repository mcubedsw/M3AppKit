/*****************************************************************
 M3ColumnVisibilityController.m
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ColumnVisibilityController.h"


@implementation M3ColumnVisibilityController

@synthesize menu = _menu;





#pragma mark -
#pragma mark Initialisers

- (id)init {
	if ((self = [super init])) {
		[self reloadMenu];
	}
	return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		[self setTableView:[aDecoder decodeObjectForKey:@"tableView"]];
		[self reloadMenu];
	}
	return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeConditionalObject:self.tableView forKey:@"tableView"];
}





#pragma mark -
#pragma mark Properties

- (void)setIgnoredColumnIdentifiers:(NSArray *)aIgnoredColumnIdentifiers {
	_ignoredColumnIdentifiers = [aIgnoredColumnIdentifiers copy];
	[self reloadMenu];
}


- (void)setTableView:(NSTableView *)view {
	if (_tableView != view) {
		_tableView = view;
		_menu = nil;
		[_tableView.headerView setMenu:self.menu];
	}
}


- (NSMenu *)menu {
	if (!_menu) {
		_menu = [NSMenu new];
		for (NSTableColumn *column in self.tableView.tableColumns) {
			if ([self.ignoredColumnIdentifiers containsObject:column.identifier]) continue;
			
			NSMenuItem *item = [NSMenuItem new];
			[item setTitle:[column.headerCell stringValue]];
			[item setRepresentedObject:column];
			[item setTarget:self];
			[item setAction:@selector(toggleColumn:)];
			[item setState:!column.isHidden];
			[_menu addItem:item];
		}
	}
	return _menu;
}





#pragma mark -
#pragma mark Misc

- (void)reloadMenu {
	_menu = nil;
	[self.tableView.headerView setMenu:self.menu];
}


- (void)toggleColumn:(NSMenuItem *)sender {
	NSTableColumn *column = sender.representedObject;
	[sender.representedObject setHidden:!column.isHidden];
	[sender setState:!column.isHidden];
}

@end
