#' Initialize tzdb for usage in other packages
#'
#' @description
#' `tzdb_initialize()` is intended to be called from a client package's
#' `.onLoad()` as `tzdb::tzdb_initialize()` to ensure that the tzdb package
#' has been loaded.
#'
#' The function itself doesn't do anything. It is instead called for the
#' side-effect of loading the tzdb package. This does two things:
#'
#' - The tzdb `.onLoad()` hook is run, which sets the path to the time zone
#' database.
#'
#' - The callables in tzdb are registered, which allows them to be called from
#' other packages.
#'
#' @details
#' There are alternative ways to ensure that tzdb is loaded. A client package
#' can alternatively import a function from tzdb into its package with the
#' `@importFrom` tag, or can call `requireNamespace("tzdb", quiet = TRUE)` from
#' its `.onLoad()`.
#'
#' @return `NULL`, invisibly.
#'
#' @export
#' @examples
#' tzdb_initialize()
tzdb_initialize <- function() {
  invisible()
}
