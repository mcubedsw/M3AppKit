/*****************************************************************
 NSObject+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 30/03/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


@interface NSObject (M3Extensions)

///-----------------------------------------------------
/// @name Perform blocks
///-----------------------------------------------------

/**
 Perform the supplied block after a delay
 This is effectively equivalent to performSelector:afterDelay:
 @param aBlock The block to perform
 @param aInterval The time interval after which the block should be invoked
 @since M3Foundation 1.0 or later
*/
- (void)m3_performBlock:(void (^)(void))aBlock afterDelay:(NSTimeInterval)aInterval;

/**
 Perform the supplied block after a delay for the supplied run loop modes
 This is effectively equivalent to performSelector:afterDelay:inModes:
 @param aBlock The block to perform
 @param aInterval The time interval after which the block should be invoked
 @param aArray An array of run loop modes
 @since M3Foundation 1.0 or later
*/
- (void)m3_performBlock:(void (^)(void))aBlock afterDelay:(NSTimeInterval)aInterval inModes:(NSArray *)aArray;





///-----------------------------------------------------
/// @name Manipulating objects
///-----------------------------------------------------

/**
 Replaces the implementation of a method on this object with the supplied block
 This method only affects the receiver and not any other instances of the class.
 @param aSelector The selector of the method to replace
 @param aBlock A block representing the implementation. The first argument must be of type id, followed by the list of method arguments
 @since M3Foundation 1.0 or later
*/
- (BOOL)m3_replaceImplementationOfMethodWithSelector:(SEL)aSelector withBlock:(id)aBlock;


@end
