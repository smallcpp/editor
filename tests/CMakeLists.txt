set(EDITOR_TESTS
    buffer
    document
    syntax
    editor)

foreach(name ${EDITOR_TESTS})
    set(source "${CMAKE_CURRENT_SOURCE_DIR}/test_${name}.scpp")
    set(program "${CMAKE_SOURCE_DIR}/bin/test-${name}")
    set(link_dir "${CMAKE_BINARY_DIR}/link-test-${name}")
    add_custom_command(
        OUTPUT "${program}"
        COMMAND "${CMAKE_COMMAND}" -E make_directory "${CMAKE_SOURCE_DIR}/bin"
        COMMAND "${CMAKE_COMMAND}" -E make_directory "${link_dir}"
        COMMAND "${CMAKE_COMMAND}" -E chdir "${link_dir}"
                "${SCPP}" ${SCPP_FLAGS} -o "${program}"
                "${source}" ${EDITOR_LIB_SOURCES} -l pthread
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
        DEPENDS "${source}" ${EDITOR_LIB_SOURCES} ${EDITOR_HEADERS} "${SCPP}"
        COMMENT "Compiling tests/test_${name}.scpp"
        VERBATIM)
    add_custom_target(test-${name} DEPENDS "${program}")
    set_target_properties(test-${name} PROPERTIES EXCLUDE_FROM_ALL TRUE)
    add_test(
        NAME test-${name}
        COMMAND ${CMAKE_COMMAND}
            -DPROGRAM=${program}
            "-DNEEDLE=test-${name} ok"
            -P ${CMAKE_CURRENT_SOURCE_DIR}/ExpectOk.cmake)
endforeach()

set(window_source "${CMAKE_CURRENT_SOURCE_DIR}/test_window.scpp")
set(window_program "${CMAKE_SOURCE_DIR}/bin/test-window")
set(window_link "${CMAKE_BINARY_DIR}/link-test-window")
add_custom_command(
    OUTPUT "${window_program}"
    COMMAND "${CMAKE_COMMAND}" -E make_directory "${CMAKE_SOURCE_DIR}/bin"
    COMMAND "${CMAKE_COMMAND}" -E make_directory "${window_link}"
    COMMAND "${CMAKE_COMMAND}" -E chdir "${window_link}"
            "${SCPP}" ${SCPP_FLAGS} -o "${window_program}"
            "${window_source}" ${EDITOR_LIB_SOURCES}
            "${CMAKE_SOURCE_DIR}/src/ui.scpp" ${EDITOR_LIBS}
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    DEPENDS "${window_source}" ${EDITOR_LIB_SOURCES}
            "${CMAKE_SOURCE_DIR}/src/ui.scpp" ${EDITOR_HEADERS} "${SCPP}"
    COMMENT "Compiling tests/test_window.scpp"
    VERBATIM)
add_custom_target(test-window DEPENDS "${window_program}")
set_target_properties(test-window PROPERTIES EXCLUDE_FROM_ALL TRUE)
add_test(
    NAME test-window
    COMMAND ${CMAKE_COMMAND}
        -DPROGRAM=${window_program}
        "-DNEEDLE=test-window ok"
        -P ${CMAKE_CURRENT_SOURCE_DIR}/ExpectWindow.cmake)

add_test(
    NAME editor-help
    COMMAND ${CMAKE_COMMAND}
        -DPROGRAM=${EDITOR_PROGRAM}
        -DMODE=help
        -P ${CMAKE_CURRENT_SOURCE_DIR}/ExpectOut.cmake)
add_test(
    NAME editor-version
    COMMAND ${CMAKE_COMMAND}
        -DPROGRAM=${EDITOR_PROGRAM}
        -DMODE=version
        -P ${CMAKE_CURRENT_SOURCE_DIR}/ExpectOut.cmake)
add_test(
    NAME editor-usage
    COMMAND ${CMAKE_COMMAND}
        -DPROGRAM=${EDITOR_PROGRAM}
        -P ${CMAKE_CURRENT_SOURCE_DIR}/ExpectUsage.cmake)
