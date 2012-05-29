/*****************************************************************
 M3BetaController.m
 M3AppKit
 
 Created by Martin Pilkington on 24/10/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3BetaController.h"

@implementation M3BetaController

@synthesize betaExpired;
@synthesize betaLength;

- (id)init {
	if ((self = [super init])) {
		NSString *notificationName = [NSString stringWithFormat:@"SU%@DriverFinished", @"Update"];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updaterFinished:) name:notificationName object:nil];
		betaLength = 21;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		betaLength = [aDecoder decodeIntegerForKey:@"betaLength"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInteger:betaLength forKey:@"betaLength"];
}


- (void)performBetaCheckWithDateString:(NSString *)aDateString {
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	if ([appVersion rangeOfString:@"b"].location != NSNotFound) {
		// Idea from Brian Cooke.
		NSString *nowString = [aDateString stringByReplacingOccurrencesOfString:@"  " withString:@" "];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"MMM dd yyyy"];
		
		NSDate *nowDate = [formatter dateFromString:nowString];
		NSDate *expireDate = [nowDate dateByAddingTimeInterval:(60*60*24* betaLength)];
		[formatter release];
						
		if ([expireDate earlierDate:[NSDate date]] == expireDate) {
			betaExpired = YES;
			NSString *alertTitle = NSLocalizedString(@"This Beta Has Expired", @"Beta expiration title");
			NSString *alertMsg = NSLocalizedString(@"Please download a new version to keep using %@.", @"Beta expiration message");
			NSString *alertQuit = NSLocalizedString(@"Quit", @"Quit");
			NSString *alertCheck = NSLocalizedString(@"Check For Updates", @"Beta expiration update check prompt");
			
			NSString *classNameStart = @"SUUp";
			
			Class updaterClass = NSClassFromString([classNameStart stringByAppendingString:@"dater"]);
			//If sparkle doesn't exist then
			if (!updaterClass) {
				alertCheck = alertQuit;
				alertQuit = nil;
			}
			NSUInteger alert = NSRunAlertPanel(alertTitle, [NSString stringWithFormat:alertMsg, [[NSProcessInfo processInfo] processName]], alertCheck, alertQuit, nil);
			
			
			if (alert == 0 || !updaterClass) {
				[NSApp terminate:self];
			} else {
				//Update
				id updater = [updaterClass performSelector:@selector(sharedUpdater)];
				[updater performSelector:@selector(checkForUpdates:) withObject:self];
			}
		}
	}
}

- (void)updaterFinished:(NSNotification *)note {
	if (betaExpired) {
		[NSApp terminate:self];
	}
}
@end
