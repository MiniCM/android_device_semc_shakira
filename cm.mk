## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := X8

# Inherit device configuration
$(call inherit-product, device/semc/shakira/device_shakira.mk)

#
# Setup device specific product configuration.
#
PRODUCT_DEVICE := shakira
PRODUCT_NAME := cm_shakira
PRODUCT_BRAND := SEMC
PRODUCT_MODEL := E15i
PRODUCT_MANUFACTURER := Sony Ericsson
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=E15i BUILD_FINGERPRINT="google/yakju/maguro:4.1.1/JRO03C/398337:user/release-keys" PRIVATE_BUILD_DESC="yakju-user 4.1.1 JRO03C 398337 release-keys"
