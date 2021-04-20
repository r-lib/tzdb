#' Retrieve the time zone database version
#'
#' @return A single string containing the version number.
#'
#' @export
#' @examples
#' tzdb_version()
tzdb_version <- function() {
  tzdb_version_cpp()
}
