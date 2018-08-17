/**
 * This header is generated by class-dump-z 0.2-0.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/Preferences.framework/Preferences
 */

#import "Preferences-Structs.h"
#import "PSListController.h"


@interface PSAppListController : PSListController {
}
-(id)bundle;
-(void)tableView:(id)view didSelectRowAtIndexPath:(id)indexPath;
-(id)specifiers;
-(id)specifiersFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)childPaneSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)multiValueSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)titleValueSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)sliderSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)toggleSwitchSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)textFieldSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)radioGroupSpecifiersFromDictionary:(id)dictionary stringsTable:(id)table;
-(id)groupSpecifierFromDictionary:(id)dictionary stringsTable:(id)table;
-(void)setPreferenceValue:(id)value specifier:(id)specifier;
-(void)postThirdPartySettingDidChangeNotificationForSpecifier:(id)postThirdPartySetting;
-(id)_localizedTitlesFromUnlocalizedTitles:(id)unlocalizedTitles stringsTable:(id)table;
-(void)_setToggleSwitchSpecifierValue:(id)value specifier:(id)specifier;
-(id)_readToggleSwitchSpecifierValue:(id)value;
-(id)_valueFromUIValue:(id)uivalue specifier:(id)specifier;
-(id)_uiValueFromValue:(id)value specifier:(id)specifier;
@end

