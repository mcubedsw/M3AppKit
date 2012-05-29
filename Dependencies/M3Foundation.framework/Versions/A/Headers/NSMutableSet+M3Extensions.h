/*****************************************************************
 NSMutableSet+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 10/02/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 Adds some more set operations to NSMutableSet
 @since M3Foundation 1.0 and later
*/
@interface NSMutableSet (M3Extensions)

/**
 Modifies the receiver to represent the difference between itself and the supplied set
 @param aSet The set to difference against the receiver
 @since M3Foundation 1.0 and later
*/
- (void)m3_differenceSet:(NSSet *)aSet;

@end
