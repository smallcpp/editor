if(NOT DEFINED PROGRAM OR NOT DEFINED MODE)
    message(FATAL_ERROR "cli check is missing a path")
endif()

set(help_text "Usage: sedit [options] [file...]\n")
string(APPEND help_text
    "Opens files. With no path, an untitled buffer is shown.\n")
string(APPEND help_text "Options:\n")
string(APPEND help_text "  -h, --help\n")
string(APPEND help_text "  -V, --version\n")

if(MODE STREQUAL "help")
    set(cli_arg "--help")
    set(cli_expected "${help_text}")
elseif(MODE STREQUAL "version")
    set(cli_arg "--version")
    set(cli_expected "sedit: v0.0.1\n")
else()
    message(FATAL_ERROR "unknown cli mode ${MODE}")
endif()

execute_process(
    COMMAND "${PROGRAM}" "${cli_arg}"
    RESULT_VARIABLE run_status
    OUTPUT_VARIABLE program_output
    ERROR_VARIABLE program_error)
if(NOT run_status EQUAL 0)
    message(FATAL_ERROR
        "${PROGRAM} exited ${run_status}: ${program_error}")
endif()
if(NOT program_output STREQUAL "${cli_expected}")
    message(FATAL_ERROR "${PROGRAM} wrote '${program_output}'")
endif()
