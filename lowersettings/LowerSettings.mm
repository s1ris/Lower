#include "Preferences/Preferences.h"
#include <MessageUI/MessageUI.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#include <spawn.h>
#include <signal.h>
extern "C" CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

#define TAGA 1
#define TAGB 2
#define TAGC 3
#define TAGD 4
#define TAGE 5

@interface LowerSettingsListController : PSListController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate> {
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
	//((UIViewController *) self).navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStylePlain target:self action:@selector(confirmRespring)];
	
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
	NSString *app;
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		app = @"Tweetbot";
	}
	else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		app = @"Twitter";
	}
	else {
		app = @"Safari";
	}
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:[bundle localizedStringForKey:@"FOLLOW" value:nil table:nil] message:[NSString stringWithFormat:[bundle localizedStringForKey:@"OPEN" value:nil table:nil], app] delegate:self cancelButtonTitle:[bundle localizedStringForKey:@"NO" value:nil table:nil] otherButtonTitles:[bundle localizedStringForKey:@"YES" value:nil table:nil], nil];
	av.tag = TAGA;
	[av show];
}

-(void) confirmRespring {
	UIAlertView *avb = [[UIAlertView alloc] initWithTitle:@"Respring" message:[bundle localizedStringForKey:@"RESPRING" value:nil table:nil] delegate:self cancelButtonTitle:[bundle localizedStringForKey:@"NO" value:nil table:nil] otherButtonTitles:[bundle localizedStringForKey:@"YES" value:nil table:nil], nil];
	avb.tag = TAGB;
	[avb show];
	
}

-(void) notif {
    //CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), CFSTR("org.s1ris.lower/notif"), NULL, NULL, true);
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == TAGA && buttonIndex == 1) {
		[self openTwitter];
	}
	else if (alertView.tag == TAGB && buttonIndex == 1) {
		[self respring];
	}
}

-(void) openTwitter {
	if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tweetbot:///user_profile/s1ris"]];
	}
	else if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"twitter://user?screen_name=s1ris"]];
	}
	else {
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://twitter.com/intent/follow?screen_name=s1ris"]];
	}
}

-(void) respring {
	pid_t pid;
	int status;
	const char *argv[] = {"killall", "backboardd", NULL};
	posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
	waitpid(pid, &status, WEXITED);
}

- (void)_returnKeyPressed:(id)notification {
    [self.view endEditing:1];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"org.s1ris.lower/notif" object:self];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("org.s1ris.lower/notif"), nil, nil, true);
}

@end
