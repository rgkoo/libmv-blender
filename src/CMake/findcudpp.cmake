# - Find Nlopt
# Intel Threading Building Blocks offers a rich and complete approach to expressing parallelism in a C++ program
# www.threadingbuildingblocks.org
#
# The module defines the following variables:
#  VXL_FOUND - the system has VXL
#  VXL_INCLUDE_DIR - where to find headers
#  VXL_INCLUDE_DIRS - VXL includes
#  VXL_LIBRARIES - aditional libraries
#  VXL_ROOT_DIR - root dir (ex. /usr/local)


set(CUDPP_INCLUDE_DIR ${CUDPP_ROOT_DIR}/include)

SET(CUDPP_LIB_DIR ${CUDPP_ROOT_DIR}/lib/Debug)
file(GLOB lib_files ${CUDPP_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CUDPP_LIBRARIES ${CUDPP_LIBRARIES} debug ${lib_file})
endforeach()
SET(CUDPP_LIB_DIR ${CUDPP_ROOT_DIR}/lib/Release)
file(GLOB lib_files ${CUDPP_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CUDPP_LIBRARIES ${CUDPP_LIBRARIES} optimized ${lib_file})
endforeach()

