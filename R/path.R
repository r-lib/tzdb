#' Retrieve the path to the time zone database
#'
#' @param type `[character(1)]`
#'
#'   The type of time zone database to return the path for.
#'
#'   Currently only `"text"` is supported.
#'
#' @return A single string containing the path to the database.
#'
#' @export
#' @examples
#' tzdb_path("text")
tzdb_path <- function(type) {
  if (!identical(type, "text")) {
    stop("`type` must be 'text'.", call. = FALSE)
  }

  path <- system.file("tzdata", package = "tzdb", mustWork = TRUE)
  path <- chr_reencode(path)

  path
}

tzdb_set_install <- function(path) {
  path <- chr_reencode(path)
  tzdb_set_install_cpp(path)
}

chr_reencode <- function(x) {
  if (on_windows()) {
    enc2utf8(x)
  } else {
    enc2native(x)
  }
}
on_windows <- function() {
  identical("windows", os_name())
}
os_name <- function() {
  tolower(Sys.info()[["sysname"]])
}
