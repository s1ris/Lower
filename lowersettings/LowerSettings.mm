#include "Preferences/Preferences.h"
#include <MessageUI/MessageUI.h>

@interface LowerSettingsListController : PSListController {
    NSBundle *bundle;
}
@end

@implementation LowerSettingsListController

-(void) viewWillAppear:(BOOL)animated {
    [self clearCache];
    [self reload];
    [super viewWillAppear:animated];
}

-(id) specifiers {
    if(_specifiers == nil) {
        _specifiers = [self loadSpecifiersFromPlistName:@"LowerSettings" target:self];
    }
    return _specifiers;
}

-(void) loadView {
    [super loadView];
    bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/LowerSettings.bundle"];
}

- (id)readPreferenceValue:(PSSpecifier*)specifier {
    NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
    return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    [settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
    [settings setObject:value forKey:specifier.properties[@"key"]];
    [settings writeToFile:path atomically:YES];
    CFStringRef notificationName = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
    if (notificationName) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
    }
}

-(void) follow {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[bundle localizedStringForKey:@"FOLLOW" value:nil table:nil] message:[NSString stringWithFormat:[bundle localizedStringForKey:@"OPEN" value:nil table:nil], @"Twitter"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *open = [UIAlertAction actionWithTitle:[bundle localizedStringForKey:@"YES" value:nil table:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/intent/follow?screen_name=s1ris"]];
        [alertController dismissViewControllerAnimated:1 completion:nil];
    }];
    UIAlertAction *dontOpen = [UIAlertAction actionWithTitle:[bundle localizedStringForKey:@"NO" value:nil table:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:1 completion:nil];
    }];
    [alertController addAction:open];
    [alertController addAction:dontOpen];
    [self presentViewController:alertController animated:1 completion:nil];
}

-(void) githubMe {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[bundle localizedStringForKey:@"FOLLOW" value:nil table:nil] message:[NSString stringWithFormat:[bundle localizedStringForKey:@"OPEN" value:nil table:nil], @"Safari"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *open = [UIAlertAction actionWithTitle:[bundle localizedStringForKey:@"YES" value:nil table:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/s1ris/Lower"]];
        [alertController dismissViewControllerAnimated:1 completion:nil];
    }];
    UIAlertAction *dontOpen = [UIAlertAction actionWithTitle:[bundle localizedStringForKey:@"NO" value:nil table:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:1 completion:nil];
    }];
    [alertController addAction:open];
    [alertController addAction:dontOpen];
    [self presentViewController:alertController animated:1 completion:nil];
}

-(void) githubAu {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[bundle localizedStringForKey:@"FOLLOW" value:nil table:nil] message:[NSString stringWithFormat:[bundle localizedStringForKey:@"OPEN" value:nil table:nil], @"Safari"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *open = [UIAlertAction actionWithTitle:[bundle localizedStringForKey:@"YES" value:nil table:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Autruche-IOS"]];
        [alertController dismissViewControllerAnimated:1 completion:nil];
    }];
    UIAlertAction *dontOpen = [UIAlertAction actionWithTitle:[bundle localizedStringForKey:@"NO" value:nil table:nil] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:1 completion:nil];
    }];
    [alertController addAction:open];
    [alertController addAction:dontOpen];
    [self presentViewController:alertController animated:1 completion:nil];
}

-(void) notif {
    //CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), CFSTR("org.s1ris.lower/notif"), NULL, NULL, true);
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}

- (void)_returnKeyPressed:(id)notification {
    [self.view endEditing:1];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"org.s1ris.lower/notif" object:self];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}

@end
