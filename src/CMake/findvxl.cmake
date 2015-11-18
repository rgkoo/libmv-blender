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

# set VXL_INCLUDE_DIR
set(VXL_INCLUDE_DIR ${VXL_ROOT_DIR}/include)

# set NLOPT_INCLUDE_DIRS
set (VXL_INCLUDE_DIRS 
  ${VXL_INCLUDE_DIR}
  ${VXL_INCLUDE_DIR}/vxl
  ${VXL_INCLUDE_DIR}/vxl/core
  ${VXL_INCLUDE_DIR}/vxl/vcl
)

SET(VXL_LIB_DIR ${VXL_ROOT_DIR}/lib/vc12_x86/Debug)
file(GLOB lib_files ${VXL_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(VXL_LIBRARIES ${VXL_LIBRARIES} debug ${lib_file})
endforeach()
SET(VXL_LIB_DIR ${VXL_ROOT_DIR}/lib/vc12_x86/Release)
file(GLOB lib_files ${VXL_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(VXL_LIBRARIES ${VXL_LIBRARIES} optimized ${lib_file})
endforeach()

