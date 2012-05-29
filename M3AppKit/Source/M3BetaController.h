/*****************************************************************
 M3BetaController.h
 M3AppKit
 
 Created by Martin Pilkington on 24/10/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 @class CLASS_HERE
 DESCRIPTION_HERE
 @since Available in M3AppKit 1.0 and later
 */
@interface M3BetaController : NSObject <NSCoding> {
	BOOL betaExpired;
	NSUInteger betaLength;
}

/**
 @property PROPERTY_NAME
 ABSTRACT_HERE
 @since Available in M3AppKit 1.0 and later
 */
@property (readonly) BOOL betaExpired;

/**
 @property PROPERTY_NAME
 ABSTRACT_HERE
 @since Available in M3AppKit 1.0 and later
 */
@property (assign) NSUInteger betaLength;


/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)performBetaCheckWithDateString:(NSString *)aDateString;

@end
