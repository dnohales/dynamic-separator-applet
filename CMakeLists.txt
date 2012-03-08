project("dynamic-separator-applet")
cmake_minimum_required(VERSION 2.8)

#
# Application information
# 
set(PACKAGE_NAME ${PROJECT_NAME})
set(PACKAGE_VERSION_MAJOR "0")
set(PACKAGE_VERSION_MINOR "1")
set(PACKAGE_VERSION_PATCH "0")
set(PACKAGE_VERSION "${PACKAGE_VERSION_MAJOR}.${PACKAGE_VERSION_MINOR}.${PACKAGE_VERSION_PATCH}")
set (GETTEXT_PACKAGE ${PROJECT_NAME})

#
# Files
# 
install (PROGRAMS "dynamic-separator-applet" DESTINATION "lib/dynamic-separator-applet")
install(CODE "configure_file(\"${CMAKE_SOURCE_DIR}/org.gnome.panel.applet.DynamicSeparatorAppletFactory.service.in\" \"${CMAKE_BINARY_DIR}/org.gnome.panel.applet.DynamicSeparatorAppletFactory.service\")")
install (FILES "${CMAKE_BINARY_DIR}/org.gnome.panel.applet.DynamicSeparatorAppletFactory.service" DESTINATION "share/dbus-1/services")
install (FILES "org.gnome.panel.applet.DynamicSeparatorApplet.gschema.xml" DESTINATION "share/glib-2.0/schemas")
install (FILES "dynamic-separator-applet.png" DESTINATION "share/pixmaps")

# Install mo files
install(CODE "execute_process(COMMAND ./build.sh WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/po)")
install (DIRECTORY locale DESTINATION "share" FILES_MATCHING PATTERN "dynamic-separator-applet.mo")

# Install internationalized panel-applet file
install(CODE "execute_process(COMMAND intltool-merge -d po \"${CMAKE_SOURCE_DIR}/org.gnome.panel.applet.DynamicSeparatorApplet.panel-applet.in\" \"${CMAKE_BINARY_DIR}/org.gnome.panel.applet.DynamicSeparatorApplet.panel-applet.in\" WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} OUTPUT_QUIET)")
install(CODE "configure_file(\"${CMAKE_BINARY_DIR}/org.gnome.panel.applet.DynamicSeparatorApplet.panel-applet.in\" \"${CMAKE_BINARY_DIR}/org.gnome.panel.applet.DynamicSeparatorApplet.panel-applet\")")
install(FILES ${CMAKE_BINARY_DIR}/org.gnome.panel.applet.DynamicSeparatorApplet.panel-applet DESTINATION "share/gnome-panel/4.0/applets")

#
# Packaging
# 
SET(CPACK_GENERATOR "DEB")
SET(CPACK_DEBIAN_PACKAGE_MAINTAINER "Damián Nohales <damiannohales@gmail.com>")
SET(CPACK_PACKAGE_VERSION_MAJOR ${PACKAGE_VERSION_MAJOR})
SET(CPACK_PACKAGE_VERSION_MINOR ${PACKAGE_VERSION_MINOR})
SET(CPACK_PACKAGE_VERSION_PATCH ${PACKAGE_VERSION_PATCH})
SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Dynamic Separator GNOME applet
 This is an applet that helps you to adjust the GNOME Fallback applets
 in a more accurate way adding a separator whose size can be configured
 by user.
 .
 I created this applet because the new version of GNOME Panel (program
 used on GNOME Fallback shell) does not allow position applets with
 pixel precision because cause some bugs. This separator try to achieve
 the same results obtained with GNOME 2 panels.")
SET(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/COPYING")
SET(CPACK_DEBIAN_PACKAGE_SECTION "gnome")
SET(CPACK_DEBIAN_PACKAGE_PRIORITY "optional")
SET(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
SET(CPACK_DEBIAN_PACKAGE_HOMEPAGE "https://github.com/eagleoneraptor/dynamic-separator-applet")
SET(CPACK_DEBIAN_PACKAGE_DEPENDS "python, python-gobject, libpanel-applet-4-0")
 
INCLUDE(CPack)
