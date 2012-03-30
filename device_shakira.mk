$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# proprietary side of the device
$(call inherit-product-if-exists, vendor/semc/shakira/device_shakira-vendor.mk)

# Discard inherited values and use our own instead.
PRODUCT_NAME := E15i
PRODUCT_DEVICE := shakira
PRODUCT_MODEL := E15i

# density in DPI of the LCD of this board. This is used to scale the UI
# appropriately. If this property is not defined, the default value is 160 dpi. 
PRODUCT_PROPERTY_OVERRIDES := \
    ro.sf.lcd_density=160

TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel
PRODUCT_COPY_FILES += \
    $(TARGET_PREBUILT_KERNEL):kernel

-include device/semc/msm7x27-common/msm7x27.mk

# These is the hardware-specific overlay, which points to the location
# of hardware-specific resource overrides, typically the frameworks and
# application settings that are stored in resourced.    
DEVICE_PACKAGE_OVERLAYS := device/semc/shakira/overlay

# Gps sensors lights and audio
PRODUCT_PACKAGES += \
    sensors.shakira \
    lights.shakira

# media configuration xml file
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/media_profiles.xml:/system/etc/media_profiles.xml

# Shakira uses medium-density artwork where available
PRODUCT_AAPT_CONFIG := normal mdpi
PRODUCT_AAPT_PREF_CONFIG := mdpi

# Extra prebuilt binaries
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/hw_config.sh:system/etc/hw_config.sh

# Wifi firmware
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/tiwlan.ini:system/etc/wifi/tiwlan.ini \
    device/semc/shakira/prebuilt/tiwlan_ap.ini:system/etc/wifi/softap/tiwlan_ap.ini

# Themes
PRODUCT_COPY_FILES += \
    device/semc/shakira/prebuilt/minicm.png:system/usr/res/minicm.png \
	device/semc/shakira/prebuilt/bootanimation.zip:system/media/bootanimation.zip

