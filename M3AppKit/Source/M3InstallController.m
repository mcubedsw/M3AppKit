/*****************************************************************
 M3InstallController.m
 
 Created by Martin Pilkington on 02/06/2007.
 
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

#import "M3InstallController.h"
#import "NSWorkspace_RBAdditions.h"


@implementation M3InstallController

- (id)init {
	if ((self = [super init])) {
		NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
		NSString *title = [NSString stringWithFormat:NSLocalizedString(@"%@ is currently running from a disk image", @"AppName is currently running from a disk image"), appName];
		NSString *body = NSLocalizedString(@"Would you like to install %@ in your applications folder before quitting?", @"Would you like to install App Name in your applications folder before quitting?");
		alert = [[NSAlert alertWithMessageText:title 
								 defaultButton:NSLocalizedString(@"Install", @"Install")
							   alternateButton:NSLocalizedString(@"Don't Install", @"Don't Install")
								   otherButton:nil
					 informativeTextWithFormat:body, appName] retain];
		[alert setShowsSuppressionButton:YES];
	}
	return self;
}

- (void)displayInstaller {
	NSString *imageFilePath = [[[NSWorkspace sharedWorkspace] propertiesForPath:[[NSBundle mainBundle] bundlePath]] objectForKey:NSWorkspace_RBimagefilepath];
	//add a check for .sparsebundle
	
	BOOL isInFileVaultSparseImage = [imageFilePath isEqualToString:[NSString stringWithFormat:@"/Users/.%@/%@.sparseimage", NSUserName(), NSUserName()]];
	BOOL isInFileVaultSparseBundle = [imageFilePath isEqualToString:[NSString stringWithFormat:@"/Users/.%@/%@.sparsebundle", NSUserName(), NSUserName()]];
	if (imageFilePath && !isInFileVaultSparseImage && !isInFileVaultSparseBundle && ![[NSUserDefaults standardUserDefaults] boolForKey:@"M3DontAskInstallAgain"]) {
		NSInteger returnValue = [alert runModal];
		if (returnValue == NSAlertDefaultReturn) {
			[self installApp];
		}
		if ([[alert suppressionButton] state] == NSOnState) {
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"M3DontAskInstallAgain"];
		}
	}
}

- (void)installApp {
	NSString *appsPath = [@"/Applications" stringByAppendingPathComponent:[[[NSBundle mainBundle] bundlePath] lastPathComponent]];
	NSString *userAppsPath = [[@"~/Applications" stringByAppendingPathComponent:[[[NSBundle mainBundle] bundlePath] lastPathComponent]] stringByExpandingTildeInPath];
	NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
	
	//Delete the app that is installed
	if ([[NSFileManager defaultManager] fileExistsAtPath:appsPath]) {
		[[NSFileManager defaultManager] removeItemAtPath:appsPath error:nil];
	}
	//Delete the app that is installed
	if ([[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] bundlePath] toPath:appsPath 
										  error:nil]) {
		NSInteger result = NSRunAlertPanel([NSString stringWithFormat:NSLocalizedString(@"%@ installed successfully", @"App Name installed successfully"), appName], 
										   [NSString stringWithFormat:NSLocalizedString(@"%@ was installed in /Applications", @"App Name was installed in /Applications"), appName], 
										   NSLocalizedString(@"Show In Finder", @"Show In Finder"), NSLocalizedString(@"Quit", @"Quit"), nil);
		if (result == 1) {
			[[NSWorkspace sharedWorkspace] selectFile:appsPath inFileViewerRootedAtPath:[appsPath stringByDeletingLastPathComponent]];
		}
	} else {
		if ([[NSFileManager defaultManager] fileExistsAtPath:userAppsPath]) {
			[[NSFileManager defaultManager] removeItemAtPath:userAppsPath error:nil];
		}
		if ([[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle] bundlePath] toPath:userAppsPath
												error:nil]) {
			NSInteger result = NSRunAlertPanel([NSString stringWithFormat:NSLocalizedString(@"%@ installed successfully", @"AppName installed successfully"), appName], 
											   [NSString stringWithFormat:NSLocalizedString(@"%@ was installed in %@", @"App Name was installed in %@"), appName, [@"~/Applications" stringByExpandingTildeInPath]], 
											   NSLocalizedString(@"Show In Finder", @"Show In Finder"), NSLocalizedString(@"Quit", @"Quit"), nil);
			if (result == 1) {
				[[NSWorkspace sharedWorkspace] selectFile:userAppsPath inFileViewerRootedAtPath:[userAppsPath stringByDeletingLastPathComponent]];
			}
		} else {
			NSRunAlertPanel([NSString stringWithFormat:NSLocalizedString(@"Could not install %@", @"Could not install App Name"), appName], 
							NSLocalizedString(@"An error occurred when installing", @"An error occurred when installing"), NSLocalizedString(@"Quit", @"Quit"), nil, nil);
		}
	}
}

@end
