test_that("stepwise linear model", {
  expect_snapshot(
    step_lm(data_wider = mtcars, formula = mpg ~ ., trace = FALSE)
    )
})
