if(NOT DEFINED PROGRAM)
    message(FATAL_ERROR "usage check is missing a path")
endif()

set(help_text "Usage: editor [options] [file...]\n")
string(APPEND help_text
    "Opens files. With no path, an untitled buffer is shown.\n")
string(APPEND help_text "Options:\n")
string(APPEND help_text "  -h, --help\n")
string(APPEND help_text "  -V, --version\n")

execute_process(
    COMMAND "${PROGRAM}" --bogus
    RESULT_VARIABLE run_status
    OUTPUT_VARIABLE program_output
    ERROR_VARIABLE program_error)
if(NOT run_status EQUAL 2)
    message(FATAL_ERROR
        "${PROGRAM} exited ${run_status}, expected 2")
endif()
if(NOT program_error STREQUAL "${help_text}")
    message(FATAL_ERROR "stderr was '${program_error}'")
endif()
if(NOT program_output STREQUAL "")
    message(FATAL_ERROR "stdout was '${program_output}'")
endif()
