/*****************************************************************
 M3ConstraintStringUtilities.m
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ConstraintStringUtilities.h"

NSException *M3ExceptionWithReason(NSString *aReason) {
	return [NSException exceptionWithName:@"Constraint String Parsing Error" reason:aReason userInfo:nil];
}