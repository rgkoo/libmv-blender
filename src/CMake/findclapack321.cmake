# - Find Nlopt
# Intel Threading Building Blocks offers a rich and complete approach to expressing parallelism in a C++ program
# www.threadingbuildingblocks.org
#
# The module defines the following variables:
#  LAPACK_FOUND - the system has LAPACK
#  LAPACK_INCLUDE_DIR - where to find headers
#  LAPACK_INCLUDE_DIRS - LAPACK includes
#  LAPACK_LIBRARIES - aditional libraries
#  LAPACK_ROOT_DIR - root dir (ex. /usr/local)

# set LAPACK_INCLUDE_DIR
set(LAPACK_INCLUDE_DIR ${LAPACK_ROOT_DIR}/include)

# set NLOPT_INCLUDE_DIRS
set (LAPACK_INCLUDE_DIRS 
  ${LAPACK_INCLUDE_DIR}
)

SET(LAPACK_LIB_DIR ${LAPACK_ROOT_DIR}/lib/vc12_x86/debug)
file(GLOB lib_files ${LAPACK_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(LAPACK_LIBRARIES ${LAPACK_LIBRARIES} debug ${lib_file})
endforeach()
SET(LAPACK_LIB_DIR ${LAPACK_ROOT_DIR}/lib/vc12_x86/release)
file(GLOB lib_files ${LAPACK_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(LAPACK_LIBRARIES ${LAPACK_LIBRARIES} optimized ${lib_file})
endforeach()

