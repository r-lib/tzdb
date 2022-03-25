test_that("can get the tzdb path", {
  expect_silent(x <- tzdb_path("text"))
  expect_length(x, 1)
  expect_type(x, "character")
})

test_that("can only use text right now", {
  expect_snapshot_error(tzdb_path("binary"))
})

test_that("path to the text `tzdata` can contain Unicode (#10)", {
  skip_on_cran()
  skip_if(tzdb_use_os_tzdb_cpp())

  # Get existing install location and all files to copy
  dir_old <- tzdb_path(type = "text")
  on.exit(
    expr = {
      tzdb_set_install(dir_old)
      tzdb_reload_cpp()
    },
    add = TRUE
  )

  files_old <- dir(dir_old, full.names = TRUE)
  base_names <- basename(files_old)

  # Copy files into a temp directory with a Unicode name
  dir_temp <- tempdir()

  dir_new <- paste0(dir_temp, "/", "\u5bf0\u612d")
  dir_new <- chr_reencode(dir_new)
  dir.create(dir_new)
  on.exit(unlink(dir_new, recursive = TRUE), add = TRUE)

  files_new <- paste0(dir_new, "/", base_names)
  files_new <- chr_reencode(files_new)

  copied <- file.copy(files_old, files_new)
  expect_true(all(copied))

  # Change the version in the file so we have something to check
  path_version_new <- files_new[base_names == "version"]
  expect_length(path_version_new, 1L)

  write_version <- function(path, version) {
    # Small helper to ensure we close the file before reading from it
    con <- file(path, open = "wb", encoding = "UTF-8")
    on.exit(close(con), add = TRUE)

    writeLines(version, con = con, useBytes = TRUE)
  }

  version <- chr_reencode("9999a")
  write_version(path_version_new, version)

  # Change the install directory, reload the database, and check for the new version
  tzdb_set_install(dir_new)
  tzdb_reload_cpp()

  expect_identical(tzdb_version(), version)
})

test_that("version has been reverted back to the original after running the above test (#10)", {
  skip_on_cran()
  skip_if(tzdb_use_os_tzdb_cpp())

  expect_identical(tzdb_version(), "2022a")
})
