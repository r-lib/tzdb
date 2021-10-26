test_that("can get database names with known length", {
  names <- tzdb_names()
  expect_length(names, 594)
})
