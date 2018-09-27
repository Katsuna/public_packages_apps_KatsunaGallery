# Gallery2 Gradle build - Release Notes

AOSP Gallery2 uses both java, c++ native code in shared (.so) libraries, a java lib (gallerycommon) and renderscript code, androidx and AOSP java dependencies. Implementing the gradle support and creating the base for KatsunaGallery needed:

- Manually writing all the gradle build scripts from scratch by translating the Android.mk instructions to the gradle script. Importing the project in Android Studio can't work because it's not an Eclipse project.
- Implementing support for the new AndroidX dependencies https://developer.android.com/topic/libraries/support-library/androidx-overview
- Removing duplicate strings across 60 languages that can be allowed in AOSP but not in gradle
- Re-creating the java lib "gallerycommon" for gradle from scratch
- Pre-build xmp_toolkit and mp4parser java in AOSP (pie branch) and include them as prebuilt java libs
- Adding renderscript support to the gradle builds and making it compatible with the current Android.mk structure
- Adding ndk-build (native c++ code build) into the app for the two shared (.so) libraries, jni, jni_jpegstream
- Pre-build a static c++ library in AOSP tree and include it in the ndk Android.mk, libjpeg_static_ndk.a
- Fixing the build of jni_jpegstream on gradle and setting up a system for the AOSP related dependency, which can work both locally for app developers and for our Katsuna build
- Fixing the build after using the gradle "applicationId" method to rename the final package to com.katsuna.gallery without refactoring the whole code
- Include KatsunaCommon build by managing to revert back to com.android.support (instead of androidx)

# **APP WON'T WORK WITHOUT MANUALLY GRANTING PERMISSIONS.** 
The code for runtime permissions **has to be written by us**. Blame Google.

## Project Structure: 
You MUST have the following directory structure:
```
X:/Development/
    | -- frameworks
    |       | -- KatsunaCommon
    | -- external
    |       | -- libjpeg-turbo   
    | -- packages
    |       | -- apps
    |       |     | -- KatsunaGallery
```

`libjpeg-turbo` is an AOSP repository. If you want to build the app outside of the Katsuna ROM source directory, you can download the repo using:
```
git clone https://android.googlesource.com/platform/external/libjpeg-turbo
```
