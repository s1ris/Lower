/**
 * This header is generated by class-dump-z 0.2-0.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/Preferences.framework/Preferences
 */

#import "PSRootController.h"

@class NSDictionary, UIViewController;

@interface PSSetupController : PSRootController {
	NSDictionary* _rootInfo;
	UIViewController<PSController>* _parentController;
	PSRootController* _parentRootController;
}
-(void)statusBarWillChangeHeight:(id)statusBar;
-(BOOL)popupStyleIsModal;
-(BOOL)usePopupStyle;
-(void)popControllerOnParent;
-(void)pushControllerOnParentWithSpecifier:(id)specifier;
-(void)dismissAnimated:(BOOL)animated;
-(void)dismiss;
-(id)controller;
-(void)setParentController:(id)controller;
-(void)pushController:(id)controller;
-(void)viewDidDisappear:(BOOL)view;
-(void)viewWillDisappear:(BOOL)view;
-(void)setupController;
-(id)parentController;
-(void)handleURL:(id)url;
-(void)dealloc;
-(id)init;
@end

