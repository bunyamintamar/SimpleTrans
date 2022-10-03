###################################################################
###################################################################
APP_NAME        =   SimpleTrans
DESCRIPTION     =   "A simple translator app that uses google in the background"
AUTHOR          =   "Bünyamin TAMAR"
AUTHOR_MAIL     =   "bunyamintamar@yandex.com"
GITHUB_LINK     =   github.com/bunyamintamar/SimpleTrans/releases
VERSION         =   1.1
###################################################################
###################################################################

QT              +=  core gui

BEGIN_DEF       =   \"\\\"
END_DEF         =   \\\"\"

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

BASEDIR         =   $$PWD
DEPLOYDIR       =   $$BASEDIR/bin
DEB_PACKAGE     =   $${APP_NAME}_$${VERSION}
DEB_DIR         =   $$DEPLOYDIR/$$DEB_PACKAGE
OPT_DIR         =   opt/$$APP_NAME
LAUNCHER_DIR    =   usr/local/share/applications

CONFIG          +=  c++17

HEADERS         +=  $$files("*.h",   false)
SOURCES         +=  $$files("*.cpp", false)
FORMS           +=  $$files("*.ui",  false)
RESOURCES       +=  resources.qrc

TARGET          =   $${APP_NAME}

DEFINES         +=  APP_NAME=$${BEGIN_DEF}$${APP_NAME}$${END_DEF}
DEFINES         +=  APP_VERSION=$${BEGIN_DEF}$${VERSION}$${END_DEF}
DEFINES         +=  AUTHOR=$${BEGIN_DEF}$${AUTHOR}$${END_DEF}
DEFINES         +=  AUTHOR_MAIL=$${BEGIN_DEF}$${AUTHOR_MAIL}$${END_DEF}
DEFINES         +=  GITHUB_LINK=$${BEGIN_DEF}$${GITHUB_LINK}$${END_DEF}
DEFINES         +=  TRANSLATE_SHELL_PATH=$${BEGIN_DEF}/$${OPT_DIR}$${END_DEF}

OBJECTS_DIR     =   $$DEPLOYDIR/$${APP_NAME}_o
MOC_DIR         =   $$DEPLOYDIR/$${APP_NAME}_o
RCC_DIR         =   $$DEPLOYDIR/$${APP_NAME}_o
UI_DIR          =   $$DEPLOYDIR/$${APP_NAME}_o
DESTDIR         =   $$DEPLOYDIR

QMAKE_POST_LINK +=  \
                    rm -r $$DEPLOYDIR/$${APP_NAME}_o                                     && \ # delete object files
                    rm $$DEPLOYDIR/Makefile                                              && \ # delete Makefile
                    mkdir -p $$DEB_DIR/DEBIAN                                            && \ # create DEBIAN folder
                    echo "Package: $${APP_NAME}"             >  $$DEB_DIR/DEBIAN/control && \ # create control file
                    echo "Version: $${VERSION}"              >> $$DEB_DIR/DEBIAN/control && \
                    echo "Architecture: all"                 >> $$DEB_DIR/DEBIAN/control && \
                    echo "Author: $${AUTHOR}"                >> $$DEB_DIR/DEBIAN/control && \
                    echo "Maintainer: \<$${AUTHOR_MAIL}\>"   >> $$DEB_DIR/DEBIAN/control && \
                    echo "Homepage: https://$${GITHUB_LINK}" >> $$DEB_DIR/DEBIAN/control && \
                    echo "Description: $${DESCRIPTION}"      >> $$DEB_DIR/DEBIAN/control && \
                    mkdir -p $$DEB_DIR/$$OPT_DIR                                         && \ # create opt folder
                    cp $$BASEDIR/trans $$DEB_DIR/$$OPT_DIR/                              && \   # move trans script
                    cp $$DEPLOYDIR/$$APP_NAME $$DEB_DIR/$$OPT_DIR/                       && \   # move app
                    cp $$BASEDIR/translateIcon.png $$DEB_DIR/$$OPT_DIR/                  && \   # move app icon
                    mkdir -p $$DEB_DIR/$$LAUNCHER_DIR                                    && \ # create launcher folder
                    cp $$BASEDIR/$${APP_NAME}.desktop $$DEB_DIR/$$LAUNCHER_DIR           && \   # move launcher file
                    dpkg-deb --build $$DEB_DIR                                           && \ # create deb file
                    rm -r $$DEB_DIR                                                           # delete DEBIAN folder

QMAKE_CLEAN     +=  rm -r $${BASEDIR}/bin
