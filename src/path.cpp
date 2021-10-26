#include <date/tz.h>
#include <cpp11/strings.hpp>

/*
 * This function won't do anything if `USE_OS_TZDB=1`. In that case, the date
 * library will auto find the binary version of the TZDB on your computer,
 * but this doesn't work on Windows and the binary parser has some issues.
 * So instead we set `USE_OS_TZDB=0` in the Makevars so `set_install()` is
 * always run.
 */
[[cpp11::register]]
void
tzdb_set_install_cpp(const cpp11::strings& path) {
  if (path.size() != 1) {
    cpp11::stop("Internal error: Time zone database installation path should have size 1.");
  }

  std::string string_path(path[0]);

#if !USE_OS_TZDB
  date::set_install(string_path);
#endif
}

/*
 * Force a reload of the internal tzdb structure.
 * This allows you to update the database if your installation path has been
 * changed.
 */
[[cpp11::register]]
void
tzdb_reload_cpp() {
#if !USE_OS_TZDB
  date::reload_tzdb();
#endif
}

/*
 * Determine at the R level if we are using the OS tzdb or not
 */
[[cpp11::register]]
bool
tzdb_use_os_tzdb_cpp() {
#if USE_OS_TZDB
  return true;
#else
  return false;
#endif
}
