# create environment for the package use
.Timing <- new.env()

# create environment for the package use
.Configs <- new.env()


#' Print log message
#'
#' Prints a log to console or writes a log to a file
#'
#' @param msg A string
#' @param time Time of the log to be printed
#' @param logger_name A string
#' @param file A connection, or a character string naming the file to print to.
#'
PrintLogMessage <- function (msg, time, level = NULL, logger_name = NULL, file = '') {
    if (!is.null(logger_name)) {
        logger_name <- paste0('[', logger_name, ']')
    }

    if (file == '' & GetLoggingFile() != '') file <- GetLoggingFile()

    if (CompareLevel(level = level)) {
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
#' @param file Path to a file
#' @param start_or_end Wheter 'start' or 'end'
#' @param exec_time_sec Duration of code execution in seconds
#' @param indentation_level An integer
#' @param logger_name A string
#' @param file A connection, or a character string naming the file to print to.
PrintLogtimeMessage <- function (msg,
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
            paste0('[Done by ', round(exec_time_sec, 1),
                   ' sec. ', '(', exec_time_min, ' min.',')', ']'
                  )
    }

    if (!is.null(logger_name)) logger_name <- paste0('[', logger_name, ']')

    # write to file from global config if it is not empty and local file is empty
    if (file == '' & GetLoggingFile() != '') file <- GetLoggingFile()

    if (CompareLevel(level = level)) {
        cat(indentation_and_time, logger_name, level, start_or_end, msg, exec_time_msg,
            sep = ' - ', fill = TRUE, file = file,
            append = ifelse(file == '', FALSE, TRUE)
            )
    }
}

#' Set Start time of code execution
#'
#' Create variable "start_time_ + index" in .Timing env
#'
#' @return indentation level (An integer)
SetStartTime <- function () {
    env_ls <- ls(.Timing)

    if (length(env_ls) == 0) {
        new_index <- 1
    } else {
        # get indeces of 'start_time'
        indeces <- gsub('start_time_', '', env_ls)  # class character

        # set new index of new 'start_time'
        new_index <- max(as.numeric(indeces)) + 1
    }

    var_name <- paste0('start_time_', new_index)

    # save new 'start_time_ + index' to .Timing  environment
    assign(var_name, Sys.time(), envir = .Timing)

    # set level of indentation for logs
    indentation_level <- new_index - 1
    return(indentation_level)
}


#' Get And remove Start time of code execution
#'
#' Get and Remove variable "start_time_..." from .Timing env
#'
#' @return A list with start_time and indentation level (An integer)
GetAndRemoveStartTime <- function () {
    env_ls <- ls(.Timing)

    if (length(env_ls) == 0) {
        stop('There is no start_time in .Timing env')
    } else {
        # get indeces of 'start_time'
        indeces <- gsub('start_time_', '', env_ls)  # class character
    }

    # set new index of new 'start_time'
    max_index <- max(as.numeric(indeces))

    var_name <- paste0('start_time_', max_index)
    start_time <- get(var_name, envir = .Timing)

    # remove 'start_time_ + index'
    rm(list = var_name, envir = .Timing)

    indentation_level <- max_index - 1

    return(list(start_time = start_time, indentation = indentation_level))
}

#' Set logging level
#'
#' @param level A logging level
SetLoggingLevel <- function (level = 'DEBUG') {
    assign(x = 'level', value = level, envir = .Configs)
}

#' Set logging file
#'
#' @param file A connection, or a character string naming the file to print to.
SetLoggingFile <- function (file = '') {
    assign(x = 'file', value = file, envir = .Configs)
}

#' Get logging file name from .Configs environment
GetLoggingFile <- function () {
    get('file', envir = .Configs)
}

#' Compare logging levels
#'
#' @return TRUE in case when a print has to be done
CompareLevel <- function (level) {
    session_level <- get('level', envir = .Configs)

    if (session_level == 'DEBUG') {
        return(TRUE)
    } else if (level == 'DEBUG' & session_level == 'INFO') {
        return(FALSE)
    } else {
        return(TRUE)
    }
}
