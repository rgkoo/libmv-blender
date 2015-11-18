# - Find Nlopt
# Intel Threading Building Blocks offers a rich and complete approach to expressing parallelism in a C++ program
# www.threadingbuildingblocks.org
#
# The module defines the following variables:
#  CVSBA_FOUND - the system has CVSBA
#  CVSBA_INCLUDE_DIR - where to find headers
#  CVSBA_INCLUDE_DIRS - CVSBA includes
#  CVSBA_LIBRARIES - aditional libraries
#  CVSBA_ROOT_DIR - root dir (ex. /usr/local)

# set CVSBA_INCLUDE_DIR
set(CVSBA_INCLUDE_DIR ${CVSBA_ROOT_DIR}/include)

# set NLOPT_INCLUDE_DIRS
set (CVSBA_INCLUDE_DIRS 
  ${CVSBA_INCLUDE_DIR}
  ${CVSBA_INCLUDE_DIR}/cvsba
)

SET(CVSBA_LIB_DIR ${CVSBA_ROOT_DIR}/lib/vc12_x86/debug)
file(GLOB lib_files ${CVSBA_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CVSBA_LIBRARIES ${CVSBA_LIBRARIES} debug ${lib_file})
endforeach()
SET(CVSBA_LIB_DIR ${CVSBA_ROOT_DIR}/lib/vc12_x86/release)
file(GLOB lib_files ${CVSBA_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CVSBA_LIBRARIES ${CVSBA_LIBRARIES} optimized ${lib_file})
endforeach()

