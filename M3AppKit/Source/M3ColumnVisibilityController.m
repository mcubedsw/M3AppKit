/*****************************************************************
 M3ColumnVisibilityController.m
 M3Extensions
 
 Created by Martin Pilkington on 18/02/2010.
 
 Copyright (c) 2006-2010 M Cubed Software
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
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
	[menu release];
	menu = nil;
	[[[self tableView] headerView] setMenu:[self menu]];
}

- (void)setTableView:(NSTableView *)view {
	if (tableView != view) {
		[tableView release];
		tableView = [view retain];
		[menu release];
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
			
			NSMenuItem *item = [[[NSMenuItem alloc] init] autorelease];
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
