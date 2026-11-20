if(NOT DEFINED PROGRAM OR NOT DEFINED NEEDLE)
    message(FATAL_ERROR "window check is missing a path")
endif()

find_program(XVFB_RUN xvfb-run)
if(NOT XVFB_RUN)
    message(FATAL_ERROR
        "xvfb-run is required to run a window test")
endif()

execute_process(
    COMMAND "${CMAKE_COMMAND}" -E env
        --unset=WAYLAND_DISPLAY
        --unset=DISPLAY
        GDK_BACKEND=x11
        "${XVFB_RUN}" -a
        -s "-screen 0 1280x1024x24"
        "${PROGRAM}"
    RESULT_VARIABLE run_status
    OUTPUT_VARIABLE program_output
    ERROR_VARIABLE program_error)
if(NOT run_status EQUAL 0)
    message(FATAL_ERROR
        "${PROGRAM} exited ${run_status}: ${program_output}${program_error}")
endif()

set(expected "${NEEDLE}\n")
if(NOT program_output STREQUAL "${expected}")
    message(FATAL_ERROR "${PROGRAM} wrote '${program_output}'")
endif()
