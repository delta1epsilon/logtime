# create environment for the package use
.RTiming <- new.env()

#' Check if return result
#'
#' Check if a result from expression execution has to be returned
#'
#' @param expr An expression
#' @return TRUE if return / FALSE if dont
CheckIfReturnExpr <- function (expr) {
    expr <- as.character(expr)

    # split by lines
    expr <- unlist(strsplit(expr, split = '\n'))

    len <- length(expr)

    return_result <- TRUE
    if (expr[len] == '}') {
        if (grepl('(<-)|(=)', expr[len - 1])) {
            return_result <- FALSE

            if (grepl('(==)', expr[len - 1])) {
                return_result <- TRUE
            }
        }
    } else {
        if (grepl('(<-)|(=)', expr[len])) {
            return_result <- FALSE

            if (grepl('(==)', expr[len])) {
                return_result <- TRUE
            }
        }
    }

    return(return_result)
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
