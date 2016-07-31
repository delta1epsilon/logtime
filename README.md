RTiming
=================================================

The package provides possibility of code timing in easy, efficient and nice looking way.

    Logtime(message) %<% {
        expression
    }

    # prints
    # {date-time} - [Start] - [{message}]
    # {date-time} - [End] - - [Done by {exec. time} sec. ({exec. time} min.)]

# Installation


# Examples

    library(RTiming)

    gauss_random <- Logtime('Generate random numbers') %<% {
        rnorm(10000000) 
    }

    # prints:
    # 2016-07-29 18:04:15.4 - [Start] - [Generate random numbers]
    # 2016-07-29 18:04:18.9 - [End] - [Generate random numbers] - [Done by 3.48 sec. (0.06 min.)]
