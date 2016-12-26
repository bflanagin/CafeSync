# Install script for directory: /home/benjamin/Projects/CafeSync/parts/cafesync/src/app

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "//CafeSync.desktop")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/" TYPE FILE FILES "/home/benjamin/Projects/CafeSync/parts/cafesync/build/app/CafeSync.desktop")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/qml/CafeSync" TYPE FILE FILES
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/GoFundMe.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Twitter.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/DA.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/RSS.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/SlideShow.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/RotateScreen.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Main.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Payment.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/VeButton.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Twitch.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Flasher.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/SoundCloud.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/FaceBook.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Setup.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Pages.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/YouTube.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/LeftTab.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Kickstarter.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Tumblr.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Home.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Vimeo.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Etsy.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/URL.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/UpTab.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/CCreator.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/ToggleUpDown.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Linkedin.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Info.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Card.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/MainScreen.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/RightTab.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Jamendo.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/Menus.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/DownTab.qml"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/slides.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/tumblr.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/etsy.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/openseed.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/linkedin.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/soundcloud.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/facebook.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/jamendo.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/vimeo.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/youtube.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/main.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/webpage.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/kickstarter.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/gofundme.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/twitch.js"
    "/home/benjamin/Projects/CafeSync/parts/cafesync/src/app/twitter.js"
    )
endif()

