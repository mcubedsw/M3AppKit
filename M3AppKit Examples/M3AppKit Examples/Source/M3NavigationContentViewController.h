//
//  M3NavigationContentViewController.h
//  M3AppKit Examples
//
//  Created by Martin Pilkington on 14/02/2013.
//  Copyright (c) 2013 M Cubed Software Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface M3NavigationContentViewController : NSViewController <M3NavigationViewController>

- (id)initWithTitle:(NSString *)aTitle;

@property (weak) IBOutlet NSTextField *textField;
- (IBAction)nextView:(id)sender;

@end
