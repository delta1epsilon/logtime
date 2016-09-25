## ----setup, message=FALSE, warning=FALSE, include=FALSE------------------
library(logtime)

## ----log_time_1, echo=TRUE, message=FALSE, warning=FALSE-----------------
log_time ('Generate random numbers') %<% {
    norm_dist_random_numbers <- rnorm(10000000)
    exp_dist_random_numbers <- rexp(10000000)    
    pois_dist_random_numbers <- rpois(10000000, lambda = 1)
}

## ----log_message_1, echo=TRUE, message=FALSE, warning=FALSE--------------
log_message('The data frame is empty', level = 'WARNING')

## ----create_logger_1, echo=TRUE------------------------------------------
clean_data_logger <- create_logger(name = 'clean_data', 
                                   level = 'INFO', 
                                   file = 'clean_data.log'
                                   )

## ----create_logger_2, echo=TRUE------------------------------------------
clean_data_logger$log_time ('Data cleaning step X') %<% {
    # some code
}

## ----create_logger_3, echo=TRUE------------------------------------------
clean_data_logger$log_message('Something awful happened', level = 'ERROR')

