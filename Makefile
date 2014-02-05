ARCHS = armv7 armv7s arm64
TARGET = iphone:clang::
THEOS_DEVICE_IP = 192.168.1.110
export GO_EASY_ON_ME=1

include /opt/theos/makefiles/common.mk

BUNDLE_NAME = PerfumeWallpaper
PerfumeWallpaper_FILES = PerfumeWallpaper.m
PerfumeWallpaper_FRAMEWORKS = UIKit CoreGraphics
PerfumeWallpaper_PRIVATE_FRAMEWORKS = SpringBoardFoundation
PerfumeWallpaper_INSTALL_PATH = /Library/ProceduralWallpaper

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
