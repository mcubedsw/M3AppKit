/*****************************************************************
 M3BetaController.m
 
 Created by Martin Pilkington on 24/10/2008.
 Last updated by Martin Pilkington on 14/02/2009.
 
 Copyright (c) 2006-2010 M Cubed Software
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
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
