logtime: R package for logging and timing
=================================================

The package provides possibility of code logging and timing in easy and efficient way.

    logtime(message) %<% {
        expression
    }

    # prints
    # {date-time} - [Start] - [{message}]
    # {date-time} - [End] - - [Done by {exec. time} sec. ({exec. time} min.)]

# Installation


# Examples

    library(logtime)

    gauss_random <- logtime('Generate random numbers') %<% {
        rnorm(10000000)
    }

    # prints:
    # 2016-07-29 18:04:15.4 - [Start] - [Generate random numbers]
    # 2016-07-29 18:04:18.9 - [End] - [Generate random numbers] - [Done by 3.48 sec. (0.06 min.)]
