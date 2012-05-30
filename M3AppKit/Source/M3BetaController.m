/*****************************************************************
 M3BetaController.m
 M3AppKit
 
 Created by Martin Pilkington on 24/10/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3BetaController.h"

typedef enum {
	M3BetaExpirationQuit,
	M3BetaExpirationCheckForUpdates
} M3BetaExpirationResult;

@interface M3BetaController ()

- (NSDate *)p_expirationDateFromDateString:(NSString *)aDateString;
- (M3BetaExpirationResult)p_runExpirationSheet;
- (void)p_performUpdate;

@end



@implementation M3BetaController

//*****//
- (id)init {
	if ((self = [super init])) {
		NSString *notificationName = [NSString stringWithFormat:@"SU%@DriverFinished", @"Update"];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updaterFinished:) name:notificationName object:nil];
		_betaLength = 21;
	}
	return self;
}

//*****//
- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init])) {
		_betaLength = [aDecoder decodeIntegerForKey:@"betaLength"];
	}
	return self;
}

//*****//
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeInteger:_betaLength forKey:@"betaLength"];
}





#pragma mark -
#pragma mark Perform the beta checks

//*****//
- (void)performBetaCheckWithDateString:(NSString *)aDateString {
	NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
	
	//If we don't have a b in the version name then we don't bother checking
	if ([appVersion rangeOfString:@"b"].location == NSNotFound) return;

	NSDate *expirationDate = [self p_expirationDateFromDateString:aDateString];
	if ([expirationDate laterDate:[NSDate date]] == expirationDate) return;
	
	_betaExpired = YES;
	
	if ([self p_runExpirationSheet] == M3BetaExpirationQuit) {
		[NSApp terminate:self];
	} else {
		[self p_performUpdate];
	}
}

//*****//
- (NSDate *)p_expirationDateFromDateString:(NSString *)aDateString {
	NSString *nowString = [aDateString stringByReplacingOccurrencesOfString:@"  " withString:@" "];
	
	NSDateFormatter *formatter = [NSDateFormatter new];
	[formatter setDateFormat:@"MMM dd yyyy"];
	
	NSDate *nowDate = [formatter dateFromString:nowString];
	return [nowDate dateByAddingTimeInterval:(60 * 60 * 24 * self.betaLength)];
}

//*****//
- (M3BetaExpirationResult)p_runExpirationSheet {
	//Get the sparkle updater class
	NSString *classNameStart = @"SUUp";
	Class updaterClass = NSClassFromString([classNameStart stringByAppendingString:@"dater"]);

	NSString *alertQuit = NSLocalizedString(@"Quit", @"Quit");
	NSString *alertCheck = NSLocalizedString(@"Check For Updates", @"Beta expiration update check prompt");
	NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"This Beta Has Expired", @"Beta expiration title")
									 defaultButton:updaterClass ? alertCheck : alertQuit
								   alternateButton:updaterClass ? alertQuit : nil
									   otherButton:nil
						 informativeTextWithFormat:NSLocalizedString(@"Please download a new version to keep using %@.", @"Beta expiration message"), [NSProcessInfo processInfo].processName];
	

	if([alert runModal] == NSOKButton) {
		return updaterClass ? M3BetaExpirationCheckForUpdates : M3BetaExpirationQuit;
	}
	return M3BetaExpirationQuit;
}

//*****//
- (void)p_performUpdate {
	NSString *classNameStart = @"SUUp";
	Class updaterClass = NSClassFromString([classNameStart stringByAppendingString:@"dater"]);
	id updater = [updaterClass performSelector:@selector(sharedUpdater)];
	[updater performSelector:@selector(checkForUpdates:) withObject:self];
}

//*****//
- (void)updaterFinished:(NSNotification *)note {
	if (_betaExpired) {
		[NSApp terminate:self];
	}
}

@end