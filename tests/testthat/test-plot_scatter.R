test_that("plot the scatters", {
  expect_snapshot(
    test <- plot_scatter(data = mtcars,
                         x = mpg,
                         y = qsec,
                         group = ~cyl,
                         cor = TRUE)
  )
})
