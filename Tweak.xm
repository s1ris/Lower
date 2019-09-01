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

    // Only-lockScreen enabled AND *not* on the lockScreen -> doing noting
    bool lockScreenOnly = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreenOnly"] boolValue];
    if (lockScreenOnly == 1 && MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") != 3)
    {
        return originalInsets;
    }

    // Determine if in landscape and load associated Preferences (https://stackoverflow.com/a/9856895)
    float yOffset;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        yOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"landscapeYStart"] floatValue];
    }
    else
    {
        yOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"portraitYStart"] floatValue];
    }

    // Updates the insets
    originalInsets.top += yOffset;
    return originalInsets;
}

-(void) _layoutListView {
    %orig;
    [self _updateListViewContentInset];
}

-(double) _minInsetsToPushDateOffScreen {
    double orig = %orig;

    // Only-lockScreen enabled AND *not* on the lockScreen -> doing noting
    bool lockScreenOnly = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreenOnly"] boolValue];
    if (lockScreenOnly == 1 && MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") != 3)
    {
        return orig;
    }

    // Determine if in landscape and load associated Preferences
    float yOffset;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        yOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"landscapeYStart"] floatValue];
    }
    else
    {
        yOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"portraitYStart"] floatValue];
    }

    return orig + yOffset;
}

-(CGRect) _suggestedListViewFrame {
    CGRect originalRect = %orig;

    // Only-lockScreen enabled AND *not* on the lockScreen -> doing noting
    bool lockScreenOnly = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreenOnly"] boolValue];
    if (lockScreenOnly == 1 && MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") != 3)
    {
        return originalRect;
    }

    // Determine if in landscape and load associated Preferences
    float xOffset;
    float xWidthOffset;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        xOffset      = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"landscapeXStart"] floatValue];
        xWidthOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"landscapeXWidth"] floatValue];
    }
    else
    {
        xOffset      = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"portraitXStart"] floatValue];
        xWidthOffset = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"portraitXWidth"] floatValue];
    }

    // Updates the originalRect
    originalRect.origin.x   += xOffset;
    originalRect.size.width += xWidthOffset;
    return originalRect;
}
%end

%hook SBLockStateAggregator
-(void) _updateLockState {
    %orig;
    // Send the command to relayout
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}
%end
