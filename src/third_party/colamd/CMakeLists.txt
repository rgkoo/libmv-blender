include_directories(../ufconfig)
include_directories(Include)
add_library(colamd ${libs_build_status} Source/colamd.c Source/colamd_global.c)

LIBMV_INSTALL_THIRD_PARTY_LIB(colamd)