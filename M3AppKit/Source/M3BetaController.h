/*****************************************************************
 M3BetaController.h
 M3AppKit
 
 Created by Martin Pilkington on 24/10/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 A class for handling beta versions and encouraging users to upgrade. The class integrates with Sparkle to show any updates if the beta expired

 Using M3BetaController
 ===================
 M3BetaController only performs the checks if the CFBundleShortVersionString propery in your Info.plist is set to a value containing a 'b',
 for example 1.2b3.
 Once you have added this to your Info.plist then M3BetaController can be used as below:
 ```
 M3BetaController *controller = [M3BetaController new];
 [controller performBetaCheckWithDataString:[NSString stringWithUTF8String:__DATE__]];
 ````
 This has the compiler insert the date the file was compiled. However, you can pass in any date you wish as long as it is in the same format.
 
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3BetaController : NSObject <NSCoding> 

/**
 Returns whether the beta period has expired
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (readonly) BOOL betaExpired;

/**
 The length of the beta period (by default it is set to 21 days)
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign) NSUInteger betaLength;


/**
 Checks if beta check needs to be performed
 @param aDateString The date string to match against, in MMM dd yyyy format
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)performBetaCheckWithDateString:(NSString *)aDateString;

@end