/**
 * This header is generated by class-dump-z 0.2-0.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/Preferences.framework/Preferences
 */

#import "Preferences-Structs.h"
#import <UIKit/UIView.h>

@class PSSpecifier;

@interface PSEditingPane : UIView {
	PSSpecifier* _specifier;
	id _delegate;
	unsigned _requiresKeyboard : 1;
	CGRect _pinstripeRect;
	UIView* _pinstripeView;
}
@property(assign, nonatomic) CGRect pinstripeRect;
+(float)preferredHeight;
+(id)defaultBackgroundColor;
-(void)didRotateFromInterfaceOrientation:(int)interfaceOrientation;
-(void)willAnimateRotationToInterfaceOrientation:(int)interfaceOrientation duration:(double)duration;
-(void)willRotateToInterfaceOrientation:(int)interfaceOrientation duration:(double)duration;
-(BOOL)changed;
-(BOOL)handlesDoneButton;
-(void)doneEditing;
-(void)editMode;
-(void)addNewValue;
-(void)viewDidBecomeVisible;
-(BOOL)wantsNewButton;
-(id)specifierLabel;
-(BOOL)requiresKeyboard;
-(id)preferenceValue;
-(void)setPreferenceValue:(id)value;
-(id)preferenceSpecifier;
-(void)setPreferenceSpecifier:(id)specifier;
-(void)setDelegate:(id)delegate;
-(void)dealloc;
-(CGRect)contentRect;
-(id)initWithFrame:(CGRect)frame;
@end

