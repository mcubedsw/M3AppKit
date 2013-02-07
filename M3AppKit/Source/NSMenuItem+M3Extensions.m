/*****************************************************************
 NSMenuItem+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 16/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSMenuItem+M3Extensions.h"

char M3MenuItemExtensionsItemIdentifierKey;

@implementation NSMenuItem (M3Extensions)


- (NSString *)m3_itemIdentifier {
	return objc_getAssociatedObject(self, &M3MenuItemExtensionsItemIdentifierKey);
}


- (void)m3_setItemIdentifier:(NSString *)itemIdentifier {
	objc_setAssociatedObject(self, &M3MenuItemExtensionsItemIdentifierKey, itemIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
