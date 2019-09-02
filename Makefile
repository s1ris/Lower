FINALPACKAGE=1
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Lower

Lower_FILES = Tweak.xm
Lower_CFLAGS = -fobjc-arc
SUBPROJECTS = lowersettings

include $(THEOS)/makefiles/tweak.mk
include $(THEOS)/makefiles/aggregate.mk
