context('Environments')

test_that('Test 1', {
    x <- 1
    logtime('Message') %<% {
        y <- x + 1
    }

    expect_equal(y, 2)
})

test_that('Test 2', {
    logtime ('Message 1') %<% {
        x <- 1

        logtime ('Message 2') %<% {
            y <- x + 1
        }

        logtime ('Message 3') %<% {
            z <- y + 1
        }
    }

    expect_equal(z, 3)
})

test_that('Test 3', {
    f <- function () {
        b <- 1
        logtime ('Message 1') %<% {
            x <- 1

            logtime ('Message 2') %<% {
                y <- x + b + 1

                logtime ('Message 3') %<% {
                    z <- y + 1
                }
            }
        }

        return(z)
    }

    expect_equal(f(), 4)
    expect_error(x)
    expect_error(y)
    expect_error(z)
})
