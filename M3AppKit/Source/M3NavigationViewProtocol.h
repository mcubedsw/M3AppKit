/*****************************************************************
 M3NavigationViewProtocol.h
 M3AppKit
 
 Created by Martin Pilkington on 21/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

@class M3NavigationView;

/**
 @protocol PROTOCOL_HERE
 DESCRIPTION_HERE
 @since Available in M3AppKit 1.0 and later
 */
@protocol M3NavigationViewProtocol

@optional

@property (assign) __weak M3NavigationView *navigationView;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)willStartAnimating;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)activateView;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)didFinishAnimating;

@end
