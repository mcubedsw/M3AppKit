/*****************************************************************
 M3InstallController.h
 M3AppKit
 
 Created by Martin Pilkington on 02/06/2007.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 @class CLASS_HERE
 DESCRIPTION_HERE
 @since Available in M3AppKit 1.0 and later
 */
@interface M3InstallController : NSObject {
	NSAlert *alert;
}


/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)displayInstaller;

/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)installApp;

@end
