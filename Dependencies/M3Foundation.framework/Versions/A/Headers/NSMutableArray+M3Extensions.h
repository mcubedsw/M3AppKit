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
 If the object doesn't exist in the array, this acts just like addObject: or insertObject:atIndex: depending on whether the index is outside the bounds of the array
 @param aObject The object to move
 @param aIndex The index to move it to
 @since M3Foundation 1.0 and later
*/
- (void)m3_moveObject:(id)aObject toIndex:(NSUInteger)aIndex;

@end
