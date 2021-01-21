TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Preferences

DEBUG = 0
FINALPACKAGE = 1


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CenteredLabels

CenteredLabels_FILES = Tweak.xm
CenteredLabels_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
