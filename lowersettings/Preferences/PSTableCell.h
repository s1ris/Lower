/**
 * This header is generated by class-dump-z 0.2-0.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/Preferences.framework/Preferences
 */

#import <UIKit/UIKit.h>

@class PSSpecifier, NSString, UIImageView, UIView;

@interface PSTableCell : UITableViewCell {
	id _value;
	UIImageView* _checkedImageView;
	BOOL _checked;
	BOOL _shouldHideTitle;
	NSString* _hiddenTitle;
	int _alignment;
	SEL _pAction;
	id _pTarget;
	BOOL _cellEnabled;
	PSSpecifier* _specifier;
	int _type;
	BOOL _lazyIcon;
	BOOL _lazyIconDontUnload;
	BOOL _lazyIconForceSynchronous;
	NSString* _lazyIconAppID;
	UIView* _topShadow;
	UIView* _topEtchLine;
	UIView* _bottomEtchLine;
	BOOL _etch;
	BOOL _reusedCell;
}
@property(assign, nonatomic) BOOL reusedCell;
@property(retain, nonatomic) PSSpecifier* specifier;
@property(assign, nonatomic) int type;
+(id)bottomEtchLineView;
+(id)topEtchLineView;
+(Class)cellClassForSpecifier:(id)specifier;
+(int)cellStyle;
+(id)reuseIdentifierForSpecifier:(id)specifier;
+(id)reuseIdentifierForClassAndType:(int)classAndType;
+(id)reuseIdentifierForBasicCellTypes:(int)basicCellTypes;
+(id)stringFromCellType:(int)cellType;
+(int)cellTypeFromString:(id)string;
-(void)_setBottomEtchHidden:(BOOL)hidden;
-(void)_setTopEtchHidden:(BOOL)hidden;
-(void)_setTopShadowHidden:(BOOL)hidden;
-(float)textFieldOffset;
-(void)reloadWithSpecifier:(id)specifier animated:(BOOL)animated;
-(BOOL)cellEnabled;
-(void)setCellEnabled:(BOOL)enabled;
-(SEL)action;
-(void)setAction:(SEL)action;
-(id)target;
-(void)setTarget:(id)target;
-(void)setAlignment:(int)alignment;
-(id)iconImageView;
-(id)valueLabel;
-(id)titleLabel;
-(id)value;
-(void)setValue:(id)value;
-(void)setIcon:(id)icon;
-(BOOL)canBeChecked;
-(BOOL)isChecked;
-(void)setChecked:(BOOL)checked;
-(void)setShouldHideTitle:(BOOL)hideTitle;
-(void)setTitle:(id)title;
-(id)title;
-(id)getIcon;
-(void)forceSynchronousIconLoadOnNextIconLoad;
-(void)cellRemovedFromView;
-(id)blankIcon;
-(id)getLazyIconID;
-(id)getLazyIcon;
-(id)_contentString;
-(BOOL)canReload;
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
-(void)setSelected:(BOOL)selected animated:(BOOL)animated;
-(void)_updateEtchState:(BOOL)state;
-(id)titleTextLabel;
-(void)setValueChangedTarget:(id)target action:(SEL)action specifier:(id)specifier;
-(void)layoutSubviews;
-(void)prepareForReuse;
-(void)refreshCellContentsWithSpecifier:(id)specifier;
-(void)dealloc;
-(id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier;
-(id)scriptingInfoWithChildren;
-(id)_automationID;
@end
