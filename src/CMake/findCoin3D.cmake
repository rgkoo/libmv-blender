set(COIN3D_INCLUDE_DIR ${COIN3D_ROOT_DIR}/include)

set(COIN3D_INCLUDE_DIRS ${COIN3D_INCLUDE_DIR})
set(COIN3D_BIN_DIR ${COIN3D_ROOT_DIR}/bin)
	SET(COIN3D_LIB_DIR ${COIN3D_ROOT_DIR}/lib/debug)
	file(GLOB lib_files ${COIN3D_LIB_DIR}/*d.lib)
	foreach(lib_file ${lib_files})
	  set(COIN3D_LIBRARIES ${COIN3D_LIBRARIES} debug ${lib_file})
	endforeach()
	SET(COIN3D_LIB_DIR ${COIN3D_ROOT_DIR}/lib/release)
	file(GLOB lib_files ${COIN3D_LIB_DIR}/*.lib)
	foreach(lib_file ${lib_files})
	  set(COIN3D_LIBRARIES ${COIN3D_LIBRARIES} optimized ${lib_file})
	endforeach()
