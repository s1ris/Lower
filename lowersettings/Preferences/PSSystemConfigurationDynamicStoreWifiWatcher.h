/**
 * This header is generated by class-dump-z 0.2-0.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/Preferences.framework/Preferences
 */

#import <Foundation/Foundation.h>
#import "Preferences-Structs.h"


@interface PSSystemConfigurationDynamicStoreWifiWatcher : NSObject {
	SCDynamicStoreRef _prefs;
	CFStringRef _wifiKey;
	CFStringRef _wifiInterface;
	CFStringRef _tetheringLink;
}
+(BOOL)wifiEnabled;
+(void)releaseSharedInstance;
+(id)sharedInstance;
-(void)dealloc;
-(id)init;
-(id)wifiConfig;
-(id)_wifiNameWithState:(id)state;
-(id)_wifiPowerWithState:(id)state;
-(id)_wifiTetheringWithState:(id)state;
-(void)findKeysAirPortState:(id*)state andTetheringState:(id*)state2;
@end

