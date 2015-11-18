include_directories(../ufconfig)
include_directories(Include)
add_library(ldl ${libs_build_status} Source/ldl.c)

LIBMV_INSTALL_THIRD_PARTY_LIB(ldl)
