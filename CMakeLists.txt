cmake_minimum_required(VERSION 3.16) # precompile headers
if(NOT DEFINED PROJECT_NAME)
  set(PROJECT_NAME mdk)
else()
  add_definitions(-DMDK_NS=${PROJECT_NAME})
endif()
if(POLICY CMP0091) # CMAKE_MSVC_RUNTIME_LIBRARY. since 3.15
  cmake_policy(SET CMP0091 NEW)
endif()

project(${PROJECT_NAME} VERSION 0.20.0 DESCRIPTION "Multimedia Dev Kit ${GIT_COMMIT}"
    #LANGUAGES C CXX OBJC OBJCXX
    )
set(PROJECT_VERSION_TWEAK 0)
set(TARGET_NAME ${PROJECT_NAME})
# https://crascit.com/2015/03/28/enabling-cxx11-in-cmake/ (global and specified target)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
#set(ENV{PKG_CONFIG_SYSROOT_DIR} "=")
#set(CMAKE_CXX_EXTENSIONS OFF)
message("CMAKE_HOST_SYSTEM_PROCESSOR: ${CMAKE_HOST_SYSTEM_PROCESSOR}, CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}, CMAKE_OSX_ARCHITECTURES: ${CMAKE_OSX_ARCHITECTURES}")
message("CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}. CMAKE_CROSSCOMPILING: ${CMAKE_CROSSCOMPILING}. LINUX: ${LINUX}")
message("CMAKE_SYSTEM_VERSION: ${CMAKE_SYSTEM_VERSION}")
message("CMAKE: ${CMAKE_VERSION}")


include(CheckLibraryExists)

set(SO_NAME ${TARGET_NAME})

if(MSVC)
  add_definitions(-D_CRT_SECURE_NO_WARNINGS -DNOMINMAX)
endif()

include_directories(
    include
    src/
    src/base/cppcompat/include
    )

file(GLOB SRC "src/core/*.cpp")
add_library(${TARGET_NAME} SHARED
    ${SRC}
)
target_compile_definitions(${TARGET_NAME} PRIVATE -DBUILD_MDK_LIB)
target_link_directories(${TARGET_NAME} PRIVATE lib)
# vpl, snappy: download from artifacts of https://github.com/wang-bin/devpkgs/actions or https://sourceforge.net/projects/mdk-sdk/files/deps/dep.7z/download
target_link_libraries(${TARGET_NAME} PRIVATE mdkObj avglue ugl ugs glva-static vpl snappy)
set_target_properties(${TARGET_NAME} PROPERTIES
    MACOSX_RPATH ON
    FRAMEWORK ON
    MACOSX_FRAMEWORK_IDENTIFIER com.mediadevkit.${TARGET_NAME}
    MACOSX_FRAMEWORK_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    #MACOSX_FRAMEWORK_INFO_PLIST
    #XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY
    FRAMEWORK_VERSION A # codesign assumes framework version is A
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
    OUTPUT_NAME ${SO_NAME}
    CLEAN_DIRECT_OUTPUT 1
)

CHECK_LIBRARY_EXISTS(dl dlopen "" HAVE_LIBDL)
if(HAVE_LIBDL)
    target_link_libraries(${TARGET_NAME} PRIVATE dl)
endif()
# only static libs are enough for reloc obj targets, otherwise static + shared
target_link_libraries(${TARGET_NAME} PRIVATE ${EXTRA_LIBS})
if(POLICY CMP0072)
    cmake_policy(SET CMP0072 NEW)
endif()
set(OpenGL_GL_PREFERENCE GLVND)
include(FindOpenGL)
if(OPENGL_FOUND)
  list(APPEND EXTRA_DYLIBS OpenGL::GL)
  target_link_libraries(${TARGET_NAME} PRIVATE OpenGL::GL)
endif()
find_package(Threads)
target_link_libraries(${TARGET_NAME} PRIVATE Threads::Threads) # link_libraries() affect targets ONLY add later

if(WIN32)
    target_link_libraries(${TARGET_NAME} PRIVATE
        mfplat mfuuid version wmcodecdspuuid
        xaudio2 dsound ole32 d3d11 user32 Mf gdi32
        advapi32
        )
endif()
