test_that("plot the distribution", {
  expect_snapshot(
    test <- plot_distribution(
      data = mtcars,
      x = mpg,
      group = ~cyl,
      bins = 50)
  )
})
