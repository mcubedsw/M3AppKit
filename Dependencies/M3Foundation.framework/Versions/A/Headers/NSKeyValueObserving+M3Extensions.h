/*****************************************************************
 NSKeyValueObserving+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 04/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


@interface NSObject (M3KeyValueObservingExtensions)

/**
 Start observing multiple key paths at once
 @param aObserver The object that will observe the receiver
 @param aKeyPaths An array of key paths to observe
 @param aOptions The options to use for observing
 @param aContext A context pointer for the observation
 @since M3Foundation 1.0 or later
 */
- (void)m3_addObserver:(NSObject *)aObserver forKeyPathsInArray:(NSArray *)aKeyPaths options:(NSKeyValueObservingOptions)aOptions context:(void *)aContext;

/**
 Stop observing multiple key paths at once
 @param aObserver The object that will stop observing the receiver
 @param aKeyPaths An array of key paths to stop observing
 @since M3Foundation 1.0 or later
 */
- (void)m3_removeObserver:(NSObject *)aObserver forKeyPathsInArray:(NSArray *)aKeyPaths;

/**
 Inform observers that we will change multiple keys
 @param aKeys An array of key paths that will change
 @since M3Foundation 1.0 or later
 */
- (void)m3_willChangeValueForKeys:(NSArray *)aKeys;

/**
 Inform observers that we did change multiple keys
 @param aKeys An array of key paths that did change
 @since M3Foundation 1.0 or later
 */
- (void)m3_didChangeValueForKeys:(NSArray *)aKeys;

@end
