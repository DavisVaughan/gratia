## Test fitted-values()

## load packages
library("testthat")
library("gratia")
library("mgcv")

test_that("fitted_values() works for a GAM", {
    expect_silent(fv <- fitted_values(m_gam))

    expect_named(fv, expected = c("x0", "x1", "x2", "x3", "fitted", "se",
                                  "lower", "upper"))

    expect_s3_class(fv, c("tbl_df", "tbl", "data.frame"))

    expect_identical(nrow(su_eg1), nrow(fv))
})

test_that("fitted_values() scale='response' works for a GAM", {
    expect_silent(fv <- fitted_values(m_gam, scale = "response"))
    expect_silent(fv2 <- fitted_values(m_gam, scale = "linear predictor"))

    expect_named(fv, expected = c("x0", "x1", "x2", "x3", "fitted", "se",
                                  "lower", "upper"))

    expect_s3_class(fv, c("tbl_df", "tbl", "data.frame"))

    expect_identical(nrow(su_eg1), nrow(fv))

    expect_identical(fv, fv2)
})

test_that("fitted_values() scale='link' works for a GAM", {
    expect_silent(fv <- fitted_values(m_gam, scale = "link"))

    expect_named(fv, expected = c("x0", "x1", "x2", "x3", "fitted", "se",
                                  "lower", "upper"))

    expect_s3_class(fv, c("tbl_df", "tbl", "data.frame"))

    expect_identical(nrow(su_eg1), nrow(fv))
})


test_that("fitted_values() works for a GAM", {
    new_df <- data_sim("eg1", n = 100,  dist = "normal", scale = 2, seed = 1)
    expect_silent(fv <- fitted_values(m_gam, data = new_df))

    expect_named(fv, expected = c(names(new_df), "fitted", "se",
                                  "lower", "upper"))

    expect_s3_class(fv, c("tbl_df", "tbl", "data.frame"))

    expect_identical(nrow(new_df), nrow(fv))
})
