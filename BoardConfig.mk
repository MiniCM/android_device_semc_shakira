-include device/semc/msm7x27-common/BoardConfigCommon.mk
-include vendor/semc/shakira/BoardConfigVendor.mk

TARGET_BOOTLOADER_BOARD_NAME := shakira
TARGET_OTA_ASSERT_DEVICE := E15i,E15a,E16i,E16a,shakira
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_BOOTLOADER_BOARD_NAME=shakira
BOARD_CAMERA_NO_AUTOFOCUS := true
BOARD_LIBSENSORS_AKM8975 := true
