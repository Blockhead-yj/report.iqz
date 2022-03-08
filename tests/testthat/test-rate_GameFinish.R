test_that("calculate game finish rate", {
  expect_snapshot(
    finish_rate <- rate_GameFinish(data = scores,
                                   idx_game = game_name,
                                   idx_user = user_id,
                                   ob_value = game_score_raw,
                                   plot = FALSE))
  })
