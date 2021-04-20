#' Time zone database names
#'
#' @description
#' `tzdb_names()` returns the time zone names found in the database.
#'
#' @return
#' A character vector of zone names.
#'
#' @export
#' @examples
#' tzdb_names()
tzdb_names <- function() {
  tzdb_names_cpp()
}
