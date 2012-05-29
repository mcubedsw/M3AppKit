/*****************************************************************
 M3BetaController.h
 M3AppKit
 
 Created by Martin Pilkington on 24/10/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3BetaController : NSObject <NSCoding> {
	BOOL betaExpired;
	NSUInteger betaLength;
}

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (readonly) BOOL betaExpired;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign) NSUInteger betaLength;


/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)performBetaCheckWithDateString:(NSString *)aDateString;

@end
