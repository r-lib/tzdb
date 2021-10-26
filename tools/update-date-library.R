library(here)
library(fs)
library(glue)

# This updater will update the embedded date library. Note that there are
# various changes made to the date library that will have to be re-added.
# All changes are marked with `tzdb-edit-start` and `tzdb-edit-stop` for
# easy searching. The changes are either related to:
#
# 1) Usage of `std::cerr()`, which is not allowed by CRAN
# 2) Additions of undocumented accessors required by clock
# 3) Additions of `tz.cpp` changes related to Unicode on Windows (#13)
#
# The `tz.cpp` file will be downloaded into `src/`.
# The header files will be downloaded into `inst/include/date/`.

# ------------------------------------------------------------------------------
# cd into temp dir
# git clone the repo

dir_temp <- tempdir()
dir_dest <- dir_create(path(dir_temp, "dest/"))

url_repo <- "https://github.com/HowardHinnant/date"

cmd_cd <- glue(shQuote("cd"), " ", dir_dest)
cmd_clone <- glue(shQuote("git"), " clone ", url_repo)
cmd <- glue(cmd_cd, "; ", cmd_clone)

# cd into temp dir
# git clone the repo
system(cmd)

dir_date <- path(dir_dest, "date")

# ------------------------------------------------------------------------------
# Update `inst/include/date/`

dir_date_include_date <- path(dir_date, "include", "date")
dir_pkg_inst_include_date <- here("inst", "include", "date")

dir_copy(dir_date_include_date, dir_pkg_inst_include_date, overwrite = TRUE)

# Remember to add the custom additions back in!

# ------------------------------------------------------------------------------
# Update `src/tz.cpp`

file_date_src_tz <- path(dir_date, "src", "tz.cpp")
file_pkg_src_tz <- path("src", "tz.cpp")

file_copy(file_date_src_tz, file_pkg_src_tz, overwrite = TRUE)

# Remember to add the custom additions back in!

# ------------------------------------------------------------------------------

unlink(dir_temp, recursive = TRUE, force = TRUE)
