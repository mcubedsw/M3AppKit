/*****************************************************************
 M3ConstraintStringComponent.m
 M3AppKit
 
 Created by Martin Pilkington on 03/09/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

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

- (NSString *)description {
	return [NSString stringWithFormat:@"<M3ConstraintStringComponent 0x%x> {\n\tkeyPath: %@\n\tattributeList: %@\n\tmultiplier: %f\n\tconstantList: %@\n}",
			(int)self, self.keyPath, [self.attributeList componentsJoinedByString:@","], self.multiplier, [self.constantList componentsJoinedByString:@","]];
}

@end
