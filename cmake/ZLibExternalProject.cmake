# If ZLib is not found in the system paths then download and build
# a copy of the library that will be linked statically.

message(STATUS "Using internal ZLib")

if(NOT EXTERN_PREFIX)
    set(EXTERN_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/extern)
endif(NOT EXTERN_PREFIX)

include(ExternalProject)
ExternalProject_Add(
    ZLib
    PREFIX ${EXTERN_PREFIX}

    #--Download step--------------
    DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/extern
    URL http://zlib.net/zlib-1.2.8.tar.gz
    URL_HASH MD5=44d667c142d7cda120332623eab69f40

    #--Update/Patch step----------
    #PATCH_COMMAND ...

    #--Configure step-------------
    CMAKE_ARGS
        -DCMAKE_INSTALL_PREFIX=${EXTERN_PREFIX}

    #--Build step-----------------
    #BUILD_COMMAND make

    #--Test step------------------
    #TEST_COMMAND make test

    #--Custom targets-------------
    STEP_TARGETS download configure build test install
)

set(LZIP_INCLUDE_DIR ${EXTERN_PREFIX}/include)
set(LZIP_LIBRARY ${EXTERN_PREFIX}/lib/libz.a)
set(LZIP_FOUND TRUE)
