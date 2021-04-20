#include <date/tz.h>
#include <cpp11/strings.hpp>

// -----------------------------------------------------------------------------

[[cpp11::register]]
cpp11::writable::strings
tzdb_version_cpp() {
  const date::tzdb& db = date::get_tzdb();
  cpp11::writable::strings out{db.version};
  return out;
}
