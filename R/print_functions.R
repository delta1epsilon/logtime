# Get log
#
# @param msg A string
# @param time Time of the log to be printed
# @param file Path to a file
# @param start_or_end Wheter NULL, 'Start' or 'End'
# @param exec_time_sec Duration of code execution in seconds
# @param indentation_level An integer
# @param level A string, NULL by default
# @param logger_name A string
# @param level A string
#
# @return A list
get_log <- function (msg,
                     time,
                     start_or_end = NULL,
                     exec_time_sec = NULL,
                     indentation_level = 0,
                     level = NULL,
                     logger_name = NULL,
                     file = ''
                     ) {
     format_log_element <- function (element) {
         if (!is.null(element)) paste0('[', element, ']')
         else NULL
     }

     # initialize log
     log <-
        list(time = NULL,
             logger_name = format_log_element(logger_name),
             level = level,
             start_or_end = format_log_element(start_or_end),
             msg = format_log_element(msg),
             exec_time_msg = NULL
             )

     # add indentation to time element
     indent_string <- paste(rep(' ', indentation_level), collapse = ' ')
     log$time <- paste0(indent_string, as.character(time))

     if (!is.null(start_or_end)) {
        if (start_or_end == 'End') {
            # execution time message
            log$exec_time_msg <-
            paste0('[Done in ', round(exec_time_sec, 1),
            ' sec. ', '(', round(exec_time_sec / 60, 1), ' min.',')', ']'
            )
        }
     }

     return(log)
}


# Print log
#
# @param log A list
# @param file A connection, or a character string naming the file to print to
# @param logger_name A string
print_log <- function (log, file = '', logger_name = NULL) {
    if (file == '' & get_logging_file() != '') file <- get_logging_file()

    if (compare_level(level = log$level)) {
        cat(unlist(log),
            sep = ' - ', fill = TRUE, file = file,
            append = ifelse(file == '', FALSE, TRUE)
            )
    }
}
