###################################################################
###################################################################
APP_NAME        =   SimpleTrans
DESCRIPTION     =   "A simple translator app that uses google in the background"
AUTHOR          =   "Bünyamin TAMAR"
AUTHOR_MAIL     =   "bunyamintamar@yandex.com"
GITHUB_LINK     =   github.com/bunyamintamar/SimpleTrans
VERSION         =   1.0
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
OPT_DIR         =   /opt/$$APP_NAME

CONFIG          +=  c++17

HEADERS         +=  $$files("*.h",   false)
SOURCES         +=  $$files("*.cpp", false)
FORMS           +=  $$files("*.ui",  false)
RESOURCES       +=  resources.qrc

TARGET          =   $${APP_NAME}

DEFINES         +=  APP_NAME=$${BEGIN_DEF}$${APP_NAME}$${END_DEF}
DEFINES         +=  APP_VERSION=$${BEGIN_DEF}$${VERSION}$${END_DEF}
DEFINES         +=  AUTHOR=$${BEGIN_DEF}$${AUTHOR}$${END_DEF}
DEFINES         +=  GITHUB_LINK=$${BEGIN_DEF}$${GITHUB_LINK}$${END_DEF}
DEFINES         +=  TRANSLATE_SHELL_PATH=$${BEGIN_DEF}$${OPT_DIR}$${END_DEF}

OBJECTS_DIR     =   $$DEPLOYDIR/$${APP_NAME}_o
MOC_DIR         =   $$DEPLOYDIR/$${APP_NAME}_o
RCC_DIR         =   $$DEPLOYDIR/$${APP_NAME}_o
UI_DIR          =   $$DEPLOYDIR/$${APP_NAME}_o
DESTDIR         =   $$DEPLOYDIR

QMAKE_POST_LINK +=  \
                    rm -r $$DEPLOYDIR/$${APP_NAME}_o                                     && \
                    rm $$DEPLOYDIR/Makefile                                              && \
                    mkdir -p $$DEB_DIR/DEBIAN                                            && \
                    echo "Package: $${APP_NAME}"             >  $$DEB_DIR/DEBIAN/control && \
                    echo "Version: $${VERSION}"              >> $$DEB_DIR/DEBIAN/control && \
                    echo "Architecture: all"                 >> $$DEB_DIR/DEBIAN/control && \
                    echo "Author: $${AUTHOR}"                >> $$DEB_DIR/DEBIAN/control && \
                    echo "Maintainer: \<$${AUTHOR_MAIL}\>"   >> $$DEB_DIR/DEBIAN/control && \
                    echo "Homepage: https://$${GITHUB_LINK}" >> $$DEB_DIR/DEBIAN/control && \
                    echo "Description: $${DESCRIPTION}"      >> $$DEB_DIR/DEBIAN/control && \
                    mkdir -p $$DEB_DIR/opt/$$APP_NAME                                    && \
                    cp $$BASEDIR/trans $$DEB_DIR/opt/$$APP_NAME                          && \
                    cp $$DEPLOYDIR/$$APP_NAME $$DEB_DIR/opt/$$APP_NAME                   && \
                    dpkg-deb --build $$DEB_DIR

QMAKE_CLEAN     +=  rm -r $${BASEDIR}/bin
