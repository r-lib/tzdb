# nocov start

.onLoad <- function(libname, pkgname) {
  path <- tzdb_path(type = "text")
  tzdb_set_install_cpp(path)
}

# nocov end
