TEMPLATE = app

QT += gui \
    quickcontrols2 \
    network

CONFIG +=  c++1z
#CONFIG += qtquickcompiler

DEFINES += QT_DEPRECATED_WARNINGS
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

HEADERS += $$files(*.hpp, true)

SOURCES += $$files(*.cpp, true)

RESOURCES += qml.qrc

QML_IMPORT_PATH += $$PWD`

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
message(TEST_SOURCE_DIR = $$TEST_SOURCE_DIR)
message(GOOGLETEST_DIR = $$GOOGLETEST_DIR)
message(ANDROID_EXTRA_LIBS = $$ANDROID_EXTRA_LIBS)
message(****  SymArt.Pro  ****)
