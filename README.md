logtime: R package for logging and timing
==============================================

## Why to use logtime package?

* It's easy to use
* Besides logging the package provides you with possibility of tracking time of code execution
* Makes code much more readable
* No dependencies on other packages

## logtime package overview


The idea of the package was inspired by function *logtime* from python library called [dslib](https://github.com/itdxer/dslib).

logtime package consists of just four functions *log_time*, *log_message*, *create_logger* and *configure_logging*. The functions names are self-explaining.

### `log_time`

The core function is `log_time` which enables logging and time tracking and makes code much more readable. Its usage:

```
log_time('message', level = 'DEBUG') %<% {
   # expression
}
# 2016-10-12 12:31:47 - DEBUG - [Start] - [message]
# 2016-10-12 12:31:47 - DEBUG - [End  ] - [message] - [Done in 0 sec. (0 min.)]
```

It evaluates an expression in calling environment. Uses pipe operator ```%<%``` which is inspired by pipe operators family introduced in [magrittr](https://github.com/smbache/magrittr) package. It allows nested calls. The call below will output execution time for all tree blocks

```
log_time('message', level = 'DEBUG') %<% {
    # expression 1

    log_time('sub_message_1', level = 'DEBUG') %<% {
        # expression 2
    }

    log_time('sub_message_2', level = 'WARNING') %<% {
        # expression 3
    }
}
# 2016-10-12 12:34:06 - DEBUG - [Start] - [message]
#  2016-10-12 12:34:06 - DEBUG - [Start] - [sub_message_1]
#  2016-10-12 12:34:06 - DEBUG - [End  ] - [sub_message_1] - [Done in 0 sec. (0 min.)]
#  2016-10-12 12:34:06 - WARNING - [Start] - [sub_message_2]
#  2016-10-12 12:34:06 - WARNING - [End  ] - [sub_message_2] - [Done in 0 sec. (0 min.)]
# 2016-10-12 12:34:06 - DEBUG - [End  ] - [message] - [Done in 0 sec. (0 min.)]
```

By default it has level DEBUG but the package supports DEBUG, INFO, WARNING and  ERROR levels.


### `log_message`


`log_message` prints a log message with specified logging level. The usage is simple:

```
log_message('message', level = 'DEBUG')
# 2016-10-12 12:36:46 - DEBUG - [message]
```

### `create_logger`

To have more control on different logging parts of the script `create_logger` function was designed. It has three arguments: logger name, logging level and optional file path or connection for writing logs to.

```
logger <- create_logger('name', level = 'INFO', file = "")
```

### `configure_logging`

And last but not least, `configure_logging` allows you to set overall threshold logging level for printing logs and to set file destination for writing logs. The usage is:

```
configure_logging(threshold_level = "INFO", output_file = "")
```

## Examples


Let's say I would like to logtime generating of random numbers.

```
log_time ('Generate random numbers') %<% {

    log_time ('Set 1') %<% {
      norm_dist_random_numbers <- rnorm(10000000)
    }

    log_time ('Set 2') %<% {
      exp_dist_random_numbers <- rexp(10000000)    
    }

    log_time ('Set 3') %<% {
      pois_dist_random_numbers <- rpois(10000000, lambda = 1)
    }
}
# 2016-10-12 12:45:29 - DEBUG - [Start] - [Generate random numbers]
#  2016-10-12 12:45:29 - DEBUG - [Start] - [Set 1]
#  2016-10-12 12:45:32 - DEBUG - [End  ] - [Set 1] - [Done in 2.8 sec. (0 min.)]
#  2016-10-12 12:45:32 - DEBUG - [Start] - [Set 2]
#  2016-10-12 12:45:34 - DEBUG - [End  ] - [Set 2] - [Done in 1.8 sec. (0 min.)]
#  2016-10-12 12:45:34 - DEBUG - [Start] - [Set 3]
#  2016-10-12 12:45:36 - DEBUG - [End  ] - [Set 3] - [Done in 1.9 sec. (0 min.)]
# 2016-10-12 12:45:36 - DEBUG - [End  ] - [Generate random numbers] -
[Done in 6.4 sec. (0.1 min.)]
```

Or let's create a log with level 'WARNING' which tells that data frame is empty.

```
log_message('The data frame is empty', level = 'WARNING')
# 2016-10-12 12:46:39 - WARNING - [The data frame is empty]
```

Let's move on and create a logger called *clean_data* with default level INFO which will write all the logs to file *clean_data.log*.

```
clean_data_logger <- create_logger(name = 'clean_data',
                                   level = 'INFO',
                                   file = 'clean_data.log'
                                   )
```

And let's logtime some process in data cleaning procedure.

```
clean_data_logger$log_time ('Data cleaning step X') %<% {
    # some code
}
# this logs go to clean_data.log file:
# 2016-10-12 12:48:50 - [clean_data] - INFO - [Start] - [Data cleaning step X]
# 2016-10-12 12:48:50 - [clean_data] - INFO - [End  ] - [Data cleaning step X] - [Done in 0 sec. (0 min.)]
```

The code above writes logs to *clean_data.log* file with logging level INFO.
By default the logger's `log_time` and `log_message` have level INFO and can be changed.


Now let's create simple log with changed level to ERROR.

```
clean_data_logger$log_message('Something awful happened', level = 'ERROR')
# goes to clean_data.log file:
# 2016-10-12 12:50:55 - [clean_data] - ERROR - [Something awful happened]
```

To set the package for printing only logs with levels INFO and higher (namely INFO, WARNING and ERROR) we write:

```
configure_logging(threshold_level = 'INFO')
```

To set the package for printing logs to *log.log* file with levels WARNING and higher we write:

```
configure_logging(threshold_level = 'WARNING', output_file = 'log.log')
```

Below is the table which indicates when a log with specific level is printed depending on threshold logging level defined in `configure_logging`.

|configure_logging \ log level |DEBUG|INFO |WARNING|ERROR|
|-------|-----|-----|-------|-----|
|**DEBUG**  |1    |1    |1      |1    |
|**INFO**   |0    |1    |1      |1    |
|**WARNING**|0    |0    |1      |1    |
|**ERROR**  |0    |0    |0      |1    |
