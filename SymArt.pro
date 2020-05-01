TEMPLATE = app

QT += gui \
    quickcontrols2 \
    network \
    widgets
# using widgets for the QML Qt.labs.platform QolorDialog

CONFIG +=  c++1z
CONFIG +=  qtquickcompiler

DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += $$files(*.hpp, true)

SOURCES += $$files(*.cpp, true)

RESOURCES += qml.qrc

QML_IMPORT_PATH += $$PWD

QML_DESIGNER_IMPORT_PATH =

wasm {
QMAKE_LFLAGS += -s SAFE_HEAP=1
QMAKE_LFLAGS += -s BINARYEN_TRAP_MODE='clamp'
QMAKE_LFLAGS += --emrun
#QMAKE_WASM_TOTAL_MEMORY=65536000
}

android {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
#    ANDROID_EXTRA_LIBS += \
#        $$PWD/android/libs/openssl/arm/libcrypto.so \
#        $$PWD/android/libs/openssl/arm/libssl.so
#}

#contains(ANDROID_TARGET_ARCH,arm64-v8a) {
#    ANDROID_EXTRA_LIBS += \
#        $$PWD/android/libs/openssl/arm64/libcrypto.so \
#        $$PWD/android/libs/openssl/arm64/libssl.so
#}

#contains(ANDROID_TARGET_ARCH,x86) {
#    ANDROID_EXTRA_LIBS += \
#        $$PWD/android/libs/openssl/x86/libcrypto.so \
#        $$PWD/android/libs/openssl/x86/libssl.so
#}

#contains(ANDROID_TARGET_ARCH,x86_64) {
#    ANDROID_EXTRA_LIBS += \
#        $$PWD/android/libs/openssl/x86_64/libcrypto.so \
#        $$PWD/android/libs/openssl/x86_64/libssl.so
#}

DISTFILES += \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/src/com/twentysixapps/symart/WallpaperGenerator.java \
    android/src/com/twentysixapps/symart/WallpaperGeneratorJobScheduler.java \
    android/src/com/twentysixapps/symart/WallpaperGeneratorJobService.java

message(****  SymArt.Pro  ****)
message(Qt version: $$[QT_VERSION])
message(Qt is installed in $$[QT_INSTALL_PREFIX])
message(Qt resources can be found in the following locations:)
message(Documentation: $$[QT_INSTALL_DOCS])
message(Header files: $$[QT_INSTALL_HEADERS])
message(Libraries: $$[QT_INSTALL_LIBS])
message(Binary files (executables): $$[QT_INSTALL_BINS])
message(Plugins: $$[QT_INSTALL_PLUGINS])
message(Data files: $$[QT_INSTALL_DATA])
message(Translation files: $$[QT_INSTALL_TRANSLATIONS])
message(Settings: $$[QT_INSTALL_CONFIGURATION])
message(PWD = $$PWD)
message(INCLUDEPATH = $$INCLUDEPATH)
message(QMAKE_WASM_TOTAL_MEMORY = $$QMAKE_WASM_TOTAL_MEMORY)
message(TEST_SOURCE_DIR = $$TEST_SOURCE_DIR)
message(GOOGLETEST_DIR = $$GOOGLETEST_DIR)
message(ANDROID_EXTRA_LIBS = $$ANDROID_EXTRA_LIBS)
message(****  SymArt.Pro  ****)





