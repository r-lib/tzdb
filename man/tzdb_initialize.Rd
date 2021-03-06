% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/initialize.R
\name{tzdb_initialize}
\alias{tzdb_initialize}
\title{Initialize tzdb for usage in other packages}
\usage{
tzdb_initialize()
}
\value{
\code{NULL}, invisibly.
}
\description{
\code{tzdb_initialize()} is intended to be called from a client package's
\code{.onLoad()} as \code{tzdb::tzdb_initialize()} to ensure that the tzdb package
has been loaded.

The function itself doesn't do anything. It is instead called for the
side-effect of loading the tzdb package. This does two things:
\itemize{
\item The tzdb \code{.onLoad()} hook is run, which sets the path to the time zone
database.
\item The callables in tzdb are registered, which allows them to be called from
other packages.
}
}
\details{
There are alternative ways to ensure that tzdb is loaded. A client package
can alternatively import a function from tzdb into its package with the
\verb{@importFrom} tag, or can call \code{requireNamespace("tzdb", quiet = TRUE)} from
its \code{.onLoad()}.
}
\examples{
tzdb_initialize()
}
