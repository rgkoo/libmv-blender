FIND_PACKAGE(Qt4 REQUIRED)
SET(QT_USE_QTOPENGL ON)
INCLUDE(${QT_USE_FILE})
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_DIR} ${GLEW_DIR}/include)
set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_DIR} ${GLEW_DIR}/lib)
find_package(glew)
INCLUDE_DIRECTORIES(${GLEW_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})
find_package(OpenGL)
add_definitions(-DGLEW)
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})
SET(SOURCES          clip.cc calibration.cc gl.cc tracker.cc zoom.cc main.cc)
QT4_WRAP_CPP(SOURCES clip.h  calibration.h        tracker.h  zoom.h  main.h)
QT4_ADD_RESOURCES(SOURCES tracker.qrc)
ADD_EXECUTABLE(qt-tracker ${SOURCES})
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
                      )
set(target qt-tracker)
#acmake_append_runtime_dirs(${target} ${bin_dirs})
#acmake_copy_dependencies(${target})

LIBMV_INSTALL_EXE(qt-tracker)
