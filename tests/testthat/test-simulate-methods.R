## Test simulate() methods

## load packages
library("testthat")
library("gratia")
library("mgcv")
library("scam")

data(smallAges)
smallAges$Error[1] <- 1.1
sw <- scam(Date ~ s(Depth, k = 5, bs = "mpd"), data = smallAges,
           weights = 1 / smallAges$Error, gamma = 1.4)

test_that("simulate() works with a gam", {
    sims <- simulate(m_gam, nsim = 5, seed = 42)
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)

    expect_message(sims <- simulate(m_gam, nsim = 5, seed = 42,
                                    newdata = su_eg1),
                   "Use of the `newdata` argument is deprecated.
Instead, use the data argument `data`.\n")
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)
})

test_that("simulate() works with a gamm", {
    sims <- simulate(m_gamm, nsim = 5, seed = 42)
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)
})

## monotonic spline age-depth model using scam() from pkg scam
test_that("simulate() works with a scam", {
    sims <- simulate(sw, nsim = 5, seed = 42)
    expect_identical(nrow(sims), 12L)
    expect_identical(ncol(sims), 5L)

    sims <- simulate(sw, nsim = 5, seed = 42, data = smallAges)
    expect_identical(nrow(sims), 12L)
    expect_identical(ncol(sims), 5L)
})

test_that("simulate() works with no .Random.seed", {
    rm(".Random.seed", envir = globalenv())
    sims <- simulate(m_gam, nsim = 5, seed = 42)
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)

    rm(".Random.seed", envir = globalenv())
    sims <- simulate(m_gamm, nsim = 5, seed = 42)
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)

    rm(".Random.seed", envir = globalenv())
    sims <- simulate(sw, nsim = 5, seed = 42)
    expect_identical(nrow(sims), 12L)
    expect_identical(ncol(sims), 5L)
})

test_that("simulate() works with out a seed", {
    sims <- simulate(m_gam, nsim = 5)
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)

    sims <- simulate(m_gamm, nsim = 5)
    expect_identical(nrow(sims), 1000L)
    expect_identical(ncol(sims), 5L)

    sims <- simulate(sw, nsim = 5)
    expect_identical(nrow(sims), 12L)
    expect_identical(ncol(sims), 5L)
})

test_that("simulate() fails if we don't have an rd function", {
    skip_on_cran()
    ## Example from ?twlss
    set.seed(3)
    n <- 400
    ## Simulate data...
    dat <- gamSim(1, n = n, dist = "poisson", scale = 0.2, verbose = FALSE)
    dat <- transform(dat, y = rTweedie(exp(f), p = 1.3, phi = 0.5)) ## Tweedie y

    ## Fit a fixed p Tweedie, with wrong link ...
    m <- gam(list(y ~ s(x0) + s(x1) + s(x2) + s(x3),
                    ~ 1,
                    ~ 1),
              family = twlss(), data = dat)

    expect_error(simulate(m),
                 "Don't yet know how to simulate from family <twlss>",
                 fixed = TRUE)
})
