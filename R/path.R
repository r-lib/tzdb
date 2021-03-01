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
  if (identical(type, "text")) {
    system.file("tzdata", package = "tzdb", mustWork = TRUE)
  } else {
    stop("`type` must be 'text'.", call. = FALSE)
  }
}
