# Copyright (c) 2007-2011 libmv authors.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

CMAKE_MINIMUM_REQUIRED(VERSION 2.2)
#koo add, force to build static libs 
set(libs_build_status STATIC)


IF (COMMAND cmake_policy)
  cmake_policy(SET CMP0003 OLD)
  cmake_policy(SET CMP0005 OLD)
ENDIF (COMMAND cmake_policy)

PROJECT(LIBMV C CXX)

ENABLE_TESTING()

set(QT_SEARCH_PATH "" CACHE PATH "Prefix prepended to Qt")
set(CMAKE_PREFIX_PATH ${CMAKE_PREFIX_PATH} ${QT_SEARCH_PATH})
set(GLEW_DIR "" CACHE PATH "Prefix prepended to GLEW")
set(FFMPEG_DIR "" CACHE PATH "Prefix prepended to FFMPEG")


SET(CMAKE_MODULE_PATH
  "${LIBMV_SOURCE_DIR}/CMake"
  "${LIBMV_SOURCE_DIR}/CMake/modules"
  "${LIBMV_SOURCE_DIR}/third_party/ceres/cmake"
  "${LIBMV_SOURCE_DIR}/CMake/acmake")
include(acmake_append_runtime_dirs)
include(acmake_copy_dependencies)
set(bin_dirs ${QT_SEARCH_PATH}/bin
  ${GLEW_DIR}/bin)
INCLUDE(LibmvVersion)

SET(LIBMV_SOURCE_DIR  ${CMAKE_CURRENT_SOURCE_DIR})
SET(LIBMV_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
SET(LIBMV_BINARY_DIR  ${PROJECT_BINARY_DIR}/bin)
SET(LIBMV_LIBRARY_DIR ${PROJECT_BINARY_DIR}/lib)

SET(LIBMV_EXECUTABLE_OUTPUT_DIR bin)
SET(LIBMV_LIBRARY_OUTPUT_DIR    lib)
IF(NOT WIN32)
  SET(LIBMV_HEADERS_OUTPUT_DIR  include/libmv)
  SET(LIBMV_SHARE_OUTPUT_DIR    share/libmv)
ELSE(NOT WIN32)
  SET(LIBMV_HEADERS_OUTPUT_DIR  include)
  SET(LIBMV_SHARE_OUTPUT_DIR    ./)
ENDIF(NOT WIN32)
SET(LIBMV_TESTS_OUTPUT_DIR      ${LIBMV_BINARY_DIR}/tests)

IF(UNIX)
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${LIBMV_LIBRARY_DIR})
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${LIBMV_LIBRARY_DIR})
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${LIBMV_BINARY_DIR})
ENDIF(UNIX)

IF(MSVC)
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   ${LIBMV_LIBRARY_DIR})
  SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${LIBMV_LIBRARY_DIR})
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG   ${LIBMV_LIBRARY_DIR})
  SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${LIBMV_LIBRARY_DIR})
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   ${LIBMV_BINARY_DIR})
  SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${LIBMV_BINARY_DIR})
ENDIF(MSVC)

OPTION(WITH_SYSTEM_CERES "Use the system Ceres library instead of bundled one" OFF)
OPTION(WITH_FAST_DETECTOR "Enable FAST detector" ON)
OPTION(BUILD_SHARED_LIBS "Build dynamic shared libraries (.dll/.so)." ON)

INCLUDE(ConfigureBuild)
INCLUDE(Documentation)
INCLUDE(Installation)
INCLUDE(Testing)

IF(WITH_SYSTEM_CERES)
  find_package(Ceres)
  IF(NOT CERES_FOUND)
    MESSAGE(FATAL_ERROR "Unable to find Ceres installed in your system!")
  ENDIF(NOT CERES_FOUND)
ELSE(WITH_SYSTEM_CERES)
  SET(CERES_INCLUDE_DIRS third_party/ceres/include)
  SET(CERES_LIBRARIES ceres)
ENDIF(WITH_SYSTEM_CERES)

# All common includ edirectories
INCLUDE_DIRECTORIES(
  .
)

# Add third_party directory before rest of include directories so
# there're no possible conflict in headers.
#
# Mainly to make Ceres happy with two gflags.h in the working tree.
ADD_SUBDIRECTORY(third_party)

# Rest of the include directories and al lactual source files goes now.
INCLUDE_DIRECTORIES(
  third_party/daisy/include
  third_party/gtest
  third_party/gtest/include
  third_party/eigen
  third_party/eigen/unsupported
  third_party/ssba
  third_party/glog/src
  third_party/gflags
  third_party/OpenExif/src
  third_party/OpenExif/src/OpenExifJpeg
  ${CERES_INCLUDE_DIRS}
)

IF (WIN32)
  INCLUDE_DIRECTORIES(
    third_party/msinttypes
    third_party/jpeg-7
    third_party/zlib
    third_party/pthreads-w32/include
    third_party/png)
ENDIF (WIN32)

IF (APPLE)
  INCLUDE_DIRECTORIES(
    third_party/png
    third_party/jpeg-7
    ${PROJECT_BINARY_DIR}/third_party/jpeg-7
  )
ENDIF (APPLE)


ADD_SUBDIRECTORY(libmv)

IF (BUILD_TESTS)
  ADD_SUBDIRECTORY(testing)
ENDIF (BUILD_TESTS)

OPTION(BUILD_GUI "Build Qt Tracker" ON)
IF (BUILD_GUI)
 MESSAGE(STATUS "GUI enabled. Make sure you have Qt (and qt-devel for binary distributions)")
 ADD_SUBDIRECTORY(ui)
ENDIF (BUILD_GUI)

OPTION(BUILD_TOOLS "Build the command line tools." OFF)
IF (BUILD_TOOLS)
  ADD_SUBDIRECTORY(tools)
ENDIF (BUILD_TOOLS)

INCLUDE(Packaging)
