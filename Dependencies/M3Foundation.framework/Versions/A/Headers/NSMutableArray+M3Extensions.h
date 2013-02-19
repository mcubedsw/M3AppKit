/*****************************************************************
 NSMutableArray+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 21/05/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 This category adds more ways of re-arranging objects in a mutable array
 @since M3Foundation 1.0 and later
*/
@interface NSMutableArray (M3Extensions)

/**
 Moves the supplied object to the new index
 If the supplied index is beyond the bounds of the array, the object is simply moved to the end of the array
 @param aIndex The index of the object to move
 @param aNewIndex The index to move the object to
 @since M3Foundation 1.0 and later
*/
- (void)m3_moveObjectAtIndex:(NSUInteger)aIndex toIndex:(NSUInteger)aNewIndex;

@end
