QT += qml quick network widgets concurrent
TARGET = gesualdo

DEFINES += HAVE_QT5
unix:!macx:DEFINES += OS_LINUX
CONFIG += c++11


qmlfolder.source = src/qml
qmlfolder.target =
iconsfolder.source = src/icons
iconsfolder.target =
DEPLOYMENTFOLDERS = qmlfolder iconsfolder

SOURCES += \
    src/main.cpp

OTHER_FILES += \
    src/qml/main.qml \
    src/qml/ToolBarSeparator.qml

include(src/deployment.pri)

#stolen from Qt Creator default project
qtcAddDeployment()
