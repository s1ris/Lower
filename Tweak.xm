#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>
#import <notify.h>
#define PLIST_PATH @"/var/mobile/Library/Preferences/org.s1ris.lowersettings.plist"
extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

@interface SBDashBoardCombinedListViewController : UIViewController
-(void) _updateListViewContentInset;
-(void) _layoutListView;
-(UIEdgeInsets) _listViewDefaultContentInsets;
+(id) sharedLVCSpinXI;
@end

@interface SBLockStateAggregator : NSObject {
    unsigned long long _lockState;
}
+(id) sharedInstance;
@end

UIEdgeInsets b;
CGRect r;
static dispatch_once_t onceToken;
static id dclvref = nil;

%hook SBDashBoardCombinedListViewController

-(id) initWithNibName:(id)arg1 bundle:(id)arg2 {
    %orig;
    dclvref = self;
    int notify_token2;
    notify_register_dispatch("org.s1ris.lower/notif", &notify_token2, dispatch_get_main_queue(), ^(int token) {
        [self _layoutListView];
    });
    return %orig;
}

-(UIEdgeInsets) _listViewDefaultContentInsets {
    b = %orig;
    float f = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"yaxis"] floatValue];
    bool lEnabled = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreen"] boolValue];
    UIEdgeInsets insets = { .left = b.left, .right = b.right, .top = b.top+f, .bottom = b.bottom };
    if (lEnabled == 1) {
        if (MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") == 3) {
            return insets;
        }
        else {
            return b;
        }
    }
    else {
        return insets;
    }
}

-(void) _layoutListView {
    %orig;
    [self _updateListViewContentInset];
}

-(double) _minInsetsToPushDateOffScreen {
    double orig = %orig;
    float f = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"yaxis"] floatValue];
    bool lEnabled = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreen"] boolValue];
    if (lEnabled == 1) {
        if (MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") == 3) {
            return orig +f;
        }
        else {
            return orig;
        }
    }
    else {
        return orig + f;
    }
}

-(CGRect) _suggestedListViewFrame {
    CGRect orig = %orig;
    float f = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"xaxis"] floatValue];
    CGRect r = CGRectMake(orig.origin.x+f, orig.origin.y, orig.size.width, orig.size.height);
    bool lEnabled = [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:@"lockScreen"] boolValue];
    if (lEnabled == 1) {
        if (MSHookIvar<NSUInteger>([objc_getClass("SBLockStateAggregator") sharedInstance], "_lockState") == 3) {
            return r;
        }
        else {
            return orig;
        }
    }
    else {
        return r;
    }
}

%new

+(id) sharedLVCSpinXI {
    return dclvref;
}

%end

%hook SBLockStateAggregator

-(void) _updateLockState {
    %orig;
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}

%end

%ctor {
    %init;
}