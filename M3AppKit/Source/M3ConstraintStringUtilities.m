//
//  M3ConstraintStringUtilities.m
//  M3AppKit
//
//  Created by Martin Pilkington on 18/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringUtilities.h"

NSException *M3ExceptionWithReason(NSString *aReason) {
	return [NSException exceptionWithName:@"Constraint String Parsing Error" reason:aReason userInfo:nil];
}