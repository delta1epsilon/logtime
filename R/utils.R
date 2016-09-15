# create environment for the package use
.RTiming <- new.env()

#' Print log message
#'
#' Prints a log to console or writes a log to a file
#'
#' @param msg A string
#' @param time Time of the log to be printed
#' @param logger_name
#' @param file A connection, or a character string naming the file to print to.
PrintLogMessage <- function (msg, time, logger_name = NULL, file = '') {
    if (!is.null(logger_name)) {
        time_and_logger_name <-
          paste(as.character(time), paste0('[', logger_name, ']'), sep = ' - ')
    } else {
        time_and_logger_name <- as.character(time)
    }

    cat(time_and_logger_name, paste0('[', msg, ']'),
        sep = ' - ', fill = TRUE, file = file,
        append = ifelse(file == '', FALSE, TRUE)
        )
}

#' Print logtime message
#'
#' Prints a logtime message to console or writes a log to a file
#'
#' @param msg A string
#' @param time Time of the log to be printed
#' @param file Path to a file
#' @param start_or_end Wheter 'start' or 'end'
#' @param exec_time_sec Duration of code execution in seconds
#' @param indentation_level An integer
#' @param logger_name
#' @param file A connection, or a character string naming the file to print to.
PrintLogtimeMessage <- function (msg,
                                 time,
                                 start_or_end = 'start',
                                 exec_time_sec = NULL,
                                 indentation_level = 0,
                                 logger_name = NULL,
                                 file = ''
                                 ) {
    stopifnot(start_or_end %in% c('start', 'end'))

    indent_string <- paste(rep(' ', indentation_level), collapse = ' ')
    indentation_and_time <- paste0(indent_string, as.character(time))

    if (start_or_end == 'start') {
        start_or_end <- '[Start]'
        msg_and_exec_time <- paste0('[', msg, ']')
    } else {
        start_or_end <- '[End]'
        exec_time_min <- round(exec_time_sec / 60, 2)

        # execution time message
        exec_time_msg <-
            paste0('[Done by ', round(exec_time_sec, 2),
                   ' sec. ', '(', exec_time_min, ' min.',')', ']'
                  )

        msg_and_exec_time <- paste(paste0('[', msg, ']'), '-', exec_time_msg)
    }

    if (!is.null(logger_name)) {
        indentation_and_time <-
          paste(indentation_and_time, paste0('[', logger_name, ']'), sep = ' - ')
    }

    cat(indentation_and_time, start_or_end, msg_and_exec_time,
        sep = ' - ', fill = TRUE, file = file,
        append = ifelse(file == '', FALSE, TRUE)
        )
}

#' Set Start time of code execution
#'
#' Create variable "start_time_ + index" in .RTiming env
#'
#' @return indentation level (An integer)
SetStartTime <- function () {
    env_ls <- ls(.RTiming)

    if (length(env_ls) == 0) {
        new_index <- 1
    } else {
        # get indeces of 'start_time'
        indeces <- gsub('start_time_', '', env_ls)  # class character

        # set new index of new 'start_time'
        new_index <- max(as.numeric(indeces)) + 1
    }

    var_name <- paste0('start_time_', new_index)

    # save new 'start_time_ + index' to .RTiming  environment
    assign(var_name, Sys.time(), envir = .RTiming)

    # set level of indentation for logs
    indentation_level <- new_index - 1
    return(indentation_level)
}


#' Get And remove Start time of code execution
#'
#' Get and Remove variable "start_time_..." from .RTiming env
#'
#' @return A list with start_time and indentation level (An integer)
GetAndRemoveStartTime <- function () {
    env_ls <- ls(.RTiming)

    if (length(env_ls) == 0) {
        stop('There is no start_time in .RTiming env')
    } else {
        # get indeces of 'start_time'
        indeces <- gsub('start_time_', '', env_ls)  # class character
    }

    # set new index of new 'start_time'
    max_index <- max(as.numeric(indeces))

    var_name <- paste0('start_time_', max_index)
    start_time <- get(var_name, envir = .RTiming)

    # remove 'start_time_ + index'
    rm(list = var_name, envir = .RTiming)

    indentation_level <- max_index - 1

    return(list(start_time = start_time, indentation = indentation_level))
}
