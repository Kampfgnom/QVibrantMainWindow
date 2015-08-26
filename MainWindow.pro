#-------------------------------------------------
#
# Project created by QtCreator 2015-08-26T19:44:06
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = MainWindow
TEMPLATE = app
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.10
QMAKE_CXXFLAGS += -Wno-unknown-pragmas
QMAKE_LIBS += -framework AppKit

SOURCES += main.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

OBJECTIVE_SOURCES += \
    mainwindow.mm
