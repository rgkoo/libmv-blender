find_package(Qt5Widgets REQUIRED)
find_package(Qt5OpenGL REQUIRED)
set(CMAKE_AUTOMOC ON)
set(AUTORCC ON)
SET(QT_USE_QTOPENGL ON)
INCLUDE(${QT_USE_FILE})
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_DIR} ${GLEW_DIR}/include)
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_DIR} ${GLEW_DIR}/lib)
find_package(glew)
INCLUDE_DIRECTORIES(${GLEW_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})

find_package(OpenGL)
add_definitions(-DGLEW)
#add_definitions(-DRECONSTRUCTION)
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${FFMPEG_DIR}/include)
set(FFMPEG_LIB_DIR ${FFMPEG_DIR}/lib)
link_directories(${FFMPEG_LIB_DIR})
SET(SOURCES          clip.cc calibration.cc gl.cc tracker.cc zoom.cc main.cc)
list(APPEND  SOURCES clip.h  calibration.h        tracker.h  zoom.h  main.h)
list(APPEND  SOURCES tracker.qrc)
ADD_EXECUTABLE(qt-tracker ${SOURCES})

#IF(${_MACHINE_ARCH_FLAG} MATCHES X86)
  SET (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /SAFESEH:NO")
  SET (CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /SAFESEH:NO")
  SET (CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} /SAFESEH:NO")
#ENDIF()
TARGET_LINK_LIBRARIES(qt-tracker
                      ${QT_LIBRARIES}
                      ${OPENGL_LIBRARIES}
                      ${FFMPEG_LIBRARIES}
                      simple_pipeline
                      tracking
                      multiview
                      image
                      ${CERES_LIBRARIES}
                      png
                      jpeg
                      gflags
                      ${GLEW_LIBRARY}
                      Qt5::Widgets
                      Qt5::Gui
                      Qt5::Core
                      Qt5::OpenGL
                      )
set(target qt-tracker)
acmake_append_runtime_dirs(${target} ${bin_dirs} ${FFMPEG_DIR}/bin)
acmake_copy_dependencies(${target})
LIBMV_INSTALL_EXE(qt-tracker)
