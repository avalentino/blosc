# If LZ4 is not found in the system paths then download and build
# a copy of the library that will be linked statically.

message(STATUS "Using internal LZ4")

if(NOT EXTERN_PREFIX)
    set(EXTERN_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/extern)
endif(NOT EXTERN_PREFIX)

include(ExternalProject)
ExternalProject_Add(
    Lz4
    PREFIX ${EXTERN_PREFIX}

    #--Download step--------------
    DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/extern
    URL http://lz4.googlecode.com/files/lz4-r110.tar.gz
    URL_HASH SHA1=57873985044711a63e40b41f2b7a11e52e7770cb

    #--Update/Patch step----------
    #PATCH_COMMAND ...

    #--Configure step-------------
    CONFIGURE_COMMAND
        ${CMAKE_COMMAND}
        -DCMAKE_INSTALL_PREFIX=${EXTERN_PREFIX}
        -DBUILD_LIBS=TRUE
        -DBUILD_TOOLS=FALSE
        -DCMAKE_C_FLAGS=-fPIC
        ${CMAKE_CURRENT_BINARY_DIR}/extern/src/Lz4/cmake

    #--Build step-----------------
    #BUILD_COMMAND make

    #--Test step------------------
    #TEST_COMMAND make test

    #--Custom targets-------------
    STEP_TARGETS download configure build test install
)

set(LZ4_INCLUDE_DIR ${EXTERN_PREFIX}/include)
set(LZ4_LIBRARY ${EXTERN_PREFIX}/lib/liblz4.a)
set(LZ4_FOUND TRUE)
