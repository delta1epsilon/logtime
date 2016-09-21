# create environment for storing start times of log_time
.Timing <- new.env()

# create environment for storing logging configs
.Configs <- new.env()


#' Set Start time of code execution
#'
#' Create variable "start_time_ + index" in .Timing env
#'
#' @return indentation level (An integer)
set_start_time <- function () {
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
get_and_remove_start_time <- function () {
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
set_logging_level <- function (level = 'DEBUG') {
    check_if_level_valid(level)
    
    assign(x = 'level', value = level, envir = .Configs)
}


#' Set logging file
#'
#' @param file A connection, or a character string naming the file to print to.
set_logging_file <- function (file = '') {
    assign(x = 'file', value = file, envir = .Configs)
}


#' Get logging file name from .Configs environment
get_logging_file <- function () {
    get('file', envir = .Configs)
}


#' Compare logging levels
#'
#' @return TRUE in case when a print has to be done
compare_level <- function (level) {
    session_level <- get('level', envir = .Configs)

    level_mapping <-
        list(DEBUG = 0,
             INFO = 1,
             WARNING = 2,
             ERROR = 3
             )

    session_level <- level_mapping[[session_level]]
    level <- level_mapping[[level]]

    if (level < session_level) {
        return(FALSE)
    } else if (level >= session_level) {
        return(TRUE)
    }
}


#' Throw an error when logging level is not valid
#'
#' @param level A logging level
check_if_level_valid <- function (level) {
    valid_levels <- c('DEBUG', 'INFO', 'WARNING', 'ERROR')

    if (!(level %in% valid_levels)) {
        stop('Logging level is not valid. Should be one of \n DEBUG, INFO, WARNING, ERROR')
    }
}
