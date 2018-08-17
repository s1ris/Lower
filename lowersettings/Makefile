export GO_EASY_ON_ME = 1

ARCHS = arm64
TARGET = iphone:clang:latest:latest

include /var/theos/makefiles/common.mk

BUNDLE_NAME = LowerSettings
LowerSettings_FILES = LowerSettings.mm
LowerSettings_INSTALL_PATH = /Library/PreferenceBundles
LowerSettings_FRAMEWORKS = UIKit MessageUI
LowerSettings_PRIVATE_FRAMEWORKS = Preferences
ADDITIONAL_OBJCFLAGS = -fobjc-arc

include /var/theos/makefiles/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LowerSettings.plist$(ECHO_END)