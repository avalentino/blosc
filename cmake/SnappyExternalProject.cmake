# If Snappy is not found in the system paths then download and build
# a copy of the library that will be linked statically.
#
# Note: a CMakeLists.txt file for building Snappy is available at
# https://github.com/okuoku/snappy-cmake

message(STATUS "Using internal Snappy")

if(NOT EXTERN_PREFIX)
    set(EXTERN_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/extern)
endif(NOT EXTERN_PREFIX)

include(ExternalProject)
ExternalProject_Add(
    Snappy
    PREFIX ${EXTERN_PREFIX}

    #--Download step--------------
    DOWNLOAD_DIR ${CMAKE_CURRENT_SOURCE_DIR}/extern
    URL http://snappy.googlecode.com/files/snappy-1.1.1.tar.gz
    URL_HASH SHA1=2988f1227622d79c1e520d4317e299b61d042852

    #--Configure step-------------
    CONFIGURE_COMMAND ${EXTERN_PREFIX}/src/Snappy/configure
        --prefix=${EXTERN_PREFIX} --disable-shared --with-pic=yes

    #--Build step-----------------
    #BUILD_COMMAND make

    #--Test step------------------
    #TEST_COMMAND make check

    #--Custom targets-------------
    STEP_TARGETS download configure build test install
)

set(SNAPPY_INCLUDE_DIR ${EXTERN_PREFIX}/include)
set(SNAPPY_LIBRARY ${EXTERN_PREFIX}/lib/libsnappy.a stdc++)
set(SNAPPY_FOUND TRUE)
