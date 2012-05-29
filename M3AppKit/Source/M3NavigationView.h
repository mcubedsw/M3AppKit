/*****************************************************************
M3NavigationView.h
M3Extensions

Created by Martin Pilkington on 18/11/2008.

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

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>
#import "M3NavigationViewProtocol.h"

@protocol M3NavigationViewDelegate;
@interface M3NavigationView : NSView

@property (readonly) NSViewController *currentViewController;
@property (assign) __weak IBOutlet id <M3NavigationViewDelegate>delegate;
@property (nonatomic, assign) BOOL showsNavigationBar;

- (void)pushViewController:(NSViewController<M3NavigationViewProtocol> *)controller animated:(BOOL)animated;
- (void)popViewControllerAnimated:(BOOL)animated;

//Convenience method
- (void)pushView:(NSView *)aView animated:(BOOL)aAnimated;

@end

@protocol M3NavigationViewDelegate <NSObject>

@optional;
- (void)navigationView:(M3NavigationView *)aView didReplaceViewController:(id)aOldController withViewController:(id)aNewController;

@end