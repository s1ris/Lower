export GO_EASY_ON_ME = 1

export ARCHS = arm64
export TARGET = iphone:clang:latest:latest

include /var/theos/makefiles/common.mk

TWEAK_NAME = Lower
Lower_FILES = Tweak.xm
Lower_FRAMEWORKS = Foundation CoreFoundation UIKit
Lower_PRIVATE_FRAMEWORKS = BulletinBoard
ADDITIONAL_OBJCFLAGS = -fobjc-arc
SUBPROJECTS = lowersettings

include /var/theos/makefiles/tweak.mk
include /var/theos/makefiles/aggregate.mk

after-install::
	install.exec "killall -9 backboardd"
