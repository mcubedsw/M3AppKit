/*****************************************************************
 M3NavigationViewProtocol.h
 M3AppKit
 
 Created by Martin Pilkington on 21/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


@class M3NavigationView;

/**
 DESCRIPTION_HERE
 @since M3AppKit 1.0 and later
 */
@protocol M3NavigationSubview

@optional

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign) M3NavigationView *navigationView;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since M3AppKit 1.0 and later
 */
- (void)willStartAnimating;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since M3AppKit 1.0 and later
 */
- (void)activateView;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since M3AppKit 1.0 and later
 */
- (void)didFinishAnimating;

@end
