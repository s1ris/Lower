FINALPACKAGE=1
export GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Lower

Lower_FILES = Tweak.xm
Lower_CFLAGS = -fobjc-arc
SUBPROJECTS = lowersettings

include $(THEOS)/makefiles/tweak.mk
include $(THEOS)/makefiles/aggregate.mk

after-install::
	install.exec "killall -9 backboardd"
