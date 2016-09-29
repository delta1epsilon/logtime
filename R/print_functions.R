#' Print log message
#'
#' Prints a log to console or writes a log to a file
#'
#' @param msg A string
#' @param time Time of the log to be printed
#' @param level A string, NULL by default
#' @param logger_name A string, NULL by default
#' @param file A connection, or a character string naming the file to print to.
#'
print_log_message <- function (msg, time, level = NULL, logger_name = NULL, file = '') {
    if (!is.null(logger_name)) {
        logger_name <- paste0('[', logger_name, ']')
    }

    if (file == '' & get_logging_file() != '') file <- get_logging_file()

    if (compare_level(level = level)) {
        cat(as.character(time), logger_name, level, paste0('[', msg, ']'),
            sep = ' - ', fill = TRUE, file = file,
            append = ifelse(file == '', FALSE, TRUE)
            )
    }
}

#' Print logtime message
#'
#' Prints a logtime message to console or writes a log to a file
#'
#' @param msg A string
#' @param time Time of the log to be printed
#' @param start_or_end Wheter 'start' or 'end'
#' @param exec_time_sec Duration of code execution in seconds
#' @param indentation_level An integer
#' @param level A string, NULL by default
#' @param logger_name A string
#' @param file A connection, or a character string naming the file to print to.
print_logtime_message <- function (msg,
                                   time,
                                   start_or_end = 'start',
                                   exec_time_sec = NULL,
                                   indentation_level = 0,
                                   level = NULL,
                                   logger_name = NULL,
                                   file = ''
                                   ) {
    stopifnot(start_or_end %in% c('start', 'end'))

    indent_string <- paste(rep(' ', indentation_level), collapse = ' ')
    indentation_and_time <- paste0(indent_string, as.character(time))

    msg <- paste0('[', msg, ']')

    if (start_or_end == 'start') {
        start_or_end <- '[Start]'
        exec_time_msg <- NULL
    } else {
        start_or_end <- '[End]'
        exec_time_min <- round(exec_time_sec / 60, 1)

        # execution time message
        exec_time_msg <-
            paste0('[Done in ', round(exec_time_sec, 1),
                   ' sec. ', '(', exec_time_min, ' min.',')', ']'
                  )
    }

    if (!is.null(logger_name)) logger_name <- paste0('[', logger_name, ']')

    # write to file from global config if it is not empty and local file is empty
    if (file == '' & get_logging_file() != '') file <- get_logging_file()

    if (compare_level(level = level)) {
        cat(indentation_and_time, logger_name, level, start_or_end, msg, exec_time_msg,
            sep = ' - ', fill = TRUE, file = file,
            append = ifelse(file == '', FALSE, TRUE)
            )
    }
}
