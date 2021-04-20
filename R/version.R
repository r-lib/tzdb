#' Time zone database version
#'
#' @description
#' `tzdb_version()` returns the version of the time zone database currently in
#' use.
#'
#' @return
#' A single string of the database version.
#'
#' @export
#' @examples
#' tzdb_version()
tzdb_version <- function() {
  tzdb_version_cpp()
}
