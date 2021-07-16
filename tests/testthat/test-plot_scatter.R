test_that("plot the scatters", {
  expect_snapshot(
    test <- plot_scatter(data = mtcars,
                   ob_value_x = "mpg",
                   ob_value_y = "qsec",
                   group = ~cyl,
                   cor = TRUE)
  )
})
