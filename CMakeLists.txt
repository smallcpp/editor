cmake_minimum_required(VERSION 3.16)
project(editor LANGUAGES NONE)

# A fresh configuration installs to $HOME/opt/smallcpp. HOME is
# expanded here, so the cache holds an absolute path.
# scripts/install can pass another prefix for one run. On CMake
# 3.29 and newer, a new build directory also takes
# CMAKE_INSTALL_PREFIX from the environment. A later configure
# keeps the cached prefix.
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT
   AND (CMAKE_VERSION VERSION_LESS 3.29
        OR NOT DEFINED ENV{CMAKE_INSTALL_PREFIX}))
    if("$ENV{HOME}" STREQUAL "")
        message(FATAL_ERROR
            "Cannot select the default install prefix: HOME is not set. "
            "Set HOME to an absolute path.")
    endif()
    if(NOT IS_ABSOLUTE "$ENV{HOME}")
        message(FATAL_ERROR
            "Cannot select the default install prefix: HOME must be absolute "
            "(got '$ENV{HOME}').")
    endif()
    get_filename_component(install_home "$ENV{HOME}" ABSOLUTE)
    set(CMAKE_INSTALL_PREFIX "${install_home}/opt/smallcpp" CACHE PATH
        "Install path prefix, prepended onto install directories." FORCE)
    set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT FALSE)
endif()

# Binaries land next to the checkout, as they do for the compiler.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin")

# The test target is defined after the other targets. It builds the
# program and the test drivers, then runs CTest. The drivers are not
# part of the default all target.
enable_testing()

# `scpp` on PATH wins. The default install prefix is $HOME/opt/smallcpp.
set(SMALLCPP_DEFAULT_BIN "")
if(IS_ABSOLUTE "$ENV{HOME}")
    set(SMALLCPP_DEFAULT_BIN "$ENV{HOME}/opt/smallcpp/bin")
endif()
if(SCPP AND NOT EXISTS "${SCPP}")
    unset(SCPP CACHE)
endif()
find_program(SCPP NAMES scpp PATHS ${SMALLCPP_DEFAULT_BIN})
if(NOT SCPP)
    unset(SCPP CACHE)
    message(FATAL_ERROR
        "scpp was not found on PATH or in \$HOME/opt/smallcpp/bin. "
        "Install smallcpp and run scripts/setup again.")
endif()

set(EDITOR_PROGRAM "${CMAKE_SOURCE_DIR}/bin/editor")

# Class definitions live in the headers. Each .scpp is one
# translation unit. string.scpp is the only unit that includes
# the language <string> header, which defines its methods.
set(EDITOR_LIB_SOURCES
    "${CMAKE_SOURCE_DIR}/src/string.scpp"
    "${CMAKE_SOURCE_DIR}/src/util.scpp"
    "${CMAKE_SOURCE_DIR}/src/buffer.scpp"
    "${CMAKE_SOURCE_DIR}/src/syntax.scpp"
    "${CMAKE_SOURCE_DIR}/src/document.scpp"
    "${CMAKE_SOURCE_DIR}/src/editor.scpp"
    "${CMAKE_SOURCE_DIR}/src/settings.scpp")

set(EDITOR_SOURCES
    ${EDITOR_LIB_SOURCES}
    "${CMAKE_SOURCE_DIR}/src/ui.scpp"
    "${CMAKE_SOURCE_DIR}/src/main.scpp")

set(EDITOR_HEADERS
    "${CMAKE_SOURCE_DIR}/src/string.shpp"
    "${CMAKE_SOURCE_DIR}/src/util.shpp"
    "${CMAKE_SOURCE_DIR}/src/buffer.shpp"
    "${CMAKE_SOURCE_DIR}/src/syntax.shpp"
    "${CMAKE_SOURCE_DIR}/src/document.shpp"
    "${CMAKE_SOURCE_DIR}/src/editor.shpp"
    "${CMAKE_SOURCE_DIR}/src/ui.shpp"
    "${CMAKE_SOURCE_DIR}/src/settings.shpp")

set(SCPP_FLAGS "")
if(CMAKE_BUILD_TYPE STREQUAL "Debug"
        OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    list(APPEND SCPP_FLAGS "-g")
endif()

set(EDITOR_LIBS
    -l smallcpp_gtk
    -l gtk-4
    -l gio-2.0
    -l gobject-2.0
    -l glib-2.0
    -l pango-1.0
    -l pangocairo-1.0
    -l cairo
    -l pthread)

set(EDITOR_LINK_DIR "${CMAKE_BINARY_DIR}/link-editor")
add_custom_command(
    OUTPUT "${EDITOR_PROGRAM}"
    COMMAND "${CMAKE_COMMAND}" -E make_directory "${CMAKE_SOURCE_DIR}/bin"
    COMMAND "${CMAKE_COMMAND}" -E make_directory "${EDITOR_LINK_DIR}"
    COMMAND "${CMAKE_COMMAND}" -E chdir "${EDITOR_LINK_DIR}"
            "${SCPP}" ${SCPP_FLAGS} -o "${EDITOR_PROGRAM}"
            ${EDITOR_SOURCES} ${EDITOR_LIBS}
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    DEPENDS ${EDITOR_SOURCES} ${EDITOR_HEADERS} "${SCPP}"
    COMMENT "Compiling editor"
    VERBATIM)
add_custom_target(editor ALL DEPENDS "${EDITOR_PROGRAM}")

# Copy the built application. This checkout is not the compiler, so
# the install does not write a config file. LIBDIR is set first
# because this project enables no language, and GNUInstallDirs warns
# otherwise.
if(NOT DEFINED CMAKE_INSTALL_LIBDIR)
    set(CMAKE_INSTALL_LIBDIR "lib" CACHE PATH "Object code libraries")
endif()
include(GNUInstallDirs)
install(PROGRAMS "${EDITOR_PROGRAM}"
    DESTINATION "${CMAKE_INSTALL_BINDIR}")

add_subdirectory(tests)

# CMake reserves the target name "test" (CMP0037). The built-in
# target can depend only on all, so an excluded driver stays out of
# `build test`. OLD keeps this project target, and generation leaves
# it in place. It depends on the drivers and on every target the
# default build includes, then runs CTest.
function(attach_test_drivers)
    set(CMAKE_WARN_DEPRECATED OFF)
    cmake_policy(SET CMP0037 OLD)
    add_custom_target(test
        COMMAND ${CMAKE_CTEST_COMMAND} --force-new-ctest-process $(ARGS)
        USES_TERMINAL)

    set(pending "${CMAKE_SOURCE_DIR}")
    set(ordinary "")
    while(pending)
        list(POP_FRONT pending dir)
        get_property(targets DIRECTORY "${dir}"
            PROPERTY BUILDSYSTEM_TARGETS)
        get_property(subs DIRECTORY "${dir}" PROPERTY SUBDIRECTORIES)
        list(APPEND pending ${subs})
        list(APPEND ordinary ${targets})
    endwhile()

    foreach(name IN LISTS ordinary)
        if(name STREQUAL "test")
            continue()
        endif()
        get_target_property(excluded ${name} EXCLUDE_FROM_ALL)
        if(excluded)
            continue()
        endif()
        add_dependencies(test ${name})
    endforeach()
    foreach(name IN LISTS ARGN)
        if(NOT TARGET ${name})
            message(FATAL_ERROR
                "Test driver '${name}' is not a target")
        endif()
        add_dependencies(test ${name})
    endforeach()
endfunction()

attach_test_drivers(
    test-buffer
    test-document
    test-syntax
    test-editor
    test-window)
