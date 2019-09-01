#import <notify.h>
#import "Tweak.h"
#define PLIST_PATH @"/var/mobile/Library/Preferences/org.s1ris.lowersettings.plist"

%hook SBDashBoardCombinedListViewController
-(id) initWithNibName:(id)arg1 bundle:(id)arg2 {
    int notify_token2;
    // Relayout on lockState change
    notify_register_dispatch("org.s1ris.lower/notif", &notify_token2, dispatch_get_main_queue(), ^(int token) {
        [self _layoutListView];
    });
    return %orig;
}

-(UIEdgeInsets) _listViewDefaultContentInsets {
    UIEdgeInsets originalInsets = %orig;

    // Load prefs
    float yOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"yaxis"] floatValue];
    bool lockScreenOnly = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreen"] boolValue];

    // Only-lockScreen enabled AND *not* on the lockScreen
    if (lockScreenOnly == 1 && MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") != 3)
    {
        return originalInsets;
    }
    else {
        // Updates the insets
        originalInsets.top += yOffset;
        return originalInsets;
    }
}

-(void) _layoutListView {
    %orig;
    [self _updateListViewContentInset];
}

-(double) _minInsetsToPushDateOffScreen {
    double orig = %orig;

    // Load prefs
    float yOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"yaxis"] floatValue];
    bool lockScreenOnly = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreen"] boolValue];

    // Only-lockScreen enabled AND *not* on the lockScreen
    if (lockScreenOnly == 1 && MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") != 3) {
        return orig;
    }
    else {
        return orig + yOffset;
    }
}

-(CGRect) _suggestedListViewFrame {
    CGRect originalRect = %orig;

    // Load prefs
    float xOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"xaxis"] floatValue];
    bool lockScreenOnly = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreen"] boolValue];

    // Only-lockScreen enabled AND *not* on the lockScreen
    if (lockScreenOnly == 1 && MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") != 3) {
        return originalRect;
    }
    else {
        // Updates the originalRect
        originalRect.origin.x += xOffset;
        return originalRect;
    }
}
%end

%hook SBLockStateAggregator
-(void) _updateLockState {
    %orig;
    // Send the command to relayout
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}
%end
