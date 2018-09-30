LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libjpeg_static_ndk
LOCAL_SRC_FILES:= $(LOCAL_PATH)/$(TARGET_ARCH)/libjpeg_static_ndk.a

# https://stackoverflow.com/a/20624954/4008886
ifneq ($(MAKECMDGOALS),clean)
    include $(PREBUILT_STATIC_LIBRARY)
endif

# Jpeg Streaming native

include $(CLEAR_VARS)

LOCAL_MODULE        := libjni_jpegstream

LOCAL_NDK_STL_VARIANT := c++_static

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
                    $(LOCAL_PATH)/src \
					$(LOCAL_PATH)/../../../../external/libjpeg-turbo

LOCAL_STATIC_LIBRARIES := libjpeg_static_ndk

LOCAL_SDK_VERSION   := 17
LOCAL_ARM_MODE := arm

LOCAL_CFLAGS    += -ffast-math -O3 -funroll-loops
LOCAL_CFLAGS += -Wall -Wextra -Werror
LOCAL_LDLIBS := -llog

LOCAL_CPP_EXTENSION := .cpp
LOCAL_SRC_FILES     := \
    src/inputstream_wrapper.cpp \
    src/jpegstream.cpp \
    src/jerr_hook.cpp \
    src/jpeg_hook.cpp \
    src/jpeg_writer.cpp \
    src/jpeg_reader.cpp \
    src/outputstream_wrapper.cpp \
    src/stream_wrapper.cpp

# https://stackoverflow.com/a/20624954/4008886
ifneq ($(MAKECMDGOALS),clean)
    include $(BUILD_SHARED_LIBRARY)
endif