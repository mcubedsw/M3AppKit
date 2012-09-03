//
//  M3ConstraintStringComponent.m
//  M3AppKit
//
//  Created by Martin Pilkington on 03/09/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringComponent.h"

@implementation M3ConstraintStringComponent

- (BOOL)isEqual:(M3ConstraintStringComponent *)aObject {
	if (![aObject isKindOfClass:self.class]) {
		return NO;
	}
	
	BOOL isEqual = [self.keyPath isEqualToString:aObject.keyPath];
	isEqual = isEqual && [self.attributeList isEqual:aObject.attributeList];
	isEqual = isEqual && (self.multiplier == aObject.multiplier);
	isEqual = isEqual && [self.constantList isEqual:aObject.constantList];
	return isEqual;
}

@end
