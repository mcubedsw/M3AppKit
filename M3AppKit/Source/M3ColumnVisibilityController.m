/*****************************************************************
 M3ColumnVisibilityController.m
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ColumnVisibilityController.h"


@implementation M3ColumnVisibilityController

@synthesize menu = _menu;

//*****//
- (id)init {
	if ((self = [super init])) {
		[self addObserver:self forKeyPath:@"ignoredColumnIdentifiers" options:0 context:NULL];
	}
	return self;
}

//*****//
- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		[self setTableView:[aDecoder decodeObjectForKey:@"tableView"]];
	}
	return self;
}

//*****//
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeConditionalObject:self.tableView forKey:@"tableView"];
}

//*****//
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	_menu = nil;
	[self.tableView.headerView setMenu:self.menu];
}

//*****//
- (void)setTableView:(NSTableView *)view {
	if (_tableView != view) {
		_tableView = view;
		_menu = nil;
		[_tableView.headerView setMenu:self.menu];
	}
}

//*****//
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

//*****//
- (void)toggleColumn:(NSMenuItem *)sender {
	NSTableColumn *column = sender.representedObject;
	[sender.representedObject setHidden:!column.isHidden];
	[sender setState:!column.isHidden];
}

@end
