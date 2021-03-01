test_that("can get the tzdb path", {
  expect_silent(x <- tzdb_path("text"))
  expect_length(x, 1)
  expect_type(x, "character")
})

test_that("can only use text right now", {
  expect_snapshot_error(tzdb_path("binary"))
})
