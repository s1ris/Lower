FINALPACKAGE=1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = LowerSettings
LowerSettings_FILES = LowerSettings.mm
LowerSettings_INSTALL_PATH = /Library/PreferenceBundles
LowerSettings_CFLAGS = -fobjc-arc
LowerSettings_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS)/makefiles/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LowerSettings.plist$(ECHO_END)
