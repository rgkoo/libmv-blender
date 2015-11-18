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
set(CGAL_INCLUDE_DIR ${CGAL_ROOT_DIR}/include)

set (CGAL_INCLUDE_DIRS 
  ${CGAL_ROOT_DIR}/auxiliary/gmp/include
  ${CGAL_INCLUDE_DIR}
)

SET(CGAL_LIB_DIR ${CGAL_ROOT_DIR}/lib/Debug)
file(GLOB lib_files ${CGAL_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CGAL_LIBRARIES ${CGAL_LIBRARIES} debug ${lib_file})
endforeach()
SET(CGAL_LIB_DIR ${CGAL_ROOT_DIR}/lib/Release)
file(GLOB lib_files ${CGAL_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CGAL_LIBRARIES ${CGAL_LIBRARIES} optimized ${lib_file})
endforeach()
SET(CGAL_LIB_DIR ${CGAL_ROOT_DIR}/auxiliary/gmp/lib)
file(GLOB lib_files ${CGAL_LIB_DIR}/*.lib)
foreach(lib_file ${lib_files})
  set(CGAL_LIBRARIES ${CGAL_LIBRARIES}  ${lib_file})
endforeach()
