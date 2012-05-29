/*****************************************************************
 NSTabView+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 20/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSTabView+M3Extensions.h"


@implementation NSTabView (M3TabView)

- (NSInteger)indexOfSelectedTab {
	return [self indexOfTabViewItem:[self selectedTabViewItem]];
}

@end
