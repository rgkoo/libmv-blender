include(acmake_use_home)

macro(acmake_try_use_home NAME)
    if(${NAME}_HOME)
        acmake_use_home(${NAME})
    else()
        message(STATUS "${NAME}_HOME not provided, fall back to system default.")
    endif()
endmacro()
