#include <date/tz.h>
#include <cpp11/strings.hpp>
#include <cpp11/protect.hpp>
#include <vector>
#include <algorithm>

// -----------------------------------------------------------------------------

#if USE_OS_TZDB

/*
 * All zone names are present in `db.zones`, even links from historic zone
 * names to their present counterparts
 */
static
cpp11::writable::strings
tzdb_names_impl() {
  const date::tzdb& db = date::get_tzdb();
  const R_xlen_t n_zones = static_cast<R_xlen_t>(db.zones.size());

  cpp11::writable::strings out(n_zones);

  cpp11::unwind_protect([&] {
    for (R_xlen_t i = 0; i < n_zones; ++i) {
      const std::string& name = db.zones[i].name();
      SEXP elt = Rf_mkCharLenCE(name.c_str(), name.size(), CE_UTF8);
      SET_STRING_ELT(out, i, elt);
    }
  });

  return out;
}

#else // !USE_OS_TZDB

/*
 * `db.zones` contains the currently used zone names
 * `db.links` contains the rest
 * Results need to be sorted in C locale to match when `USE_OS_TZDB` is used
 */
static
cpp11::writable::strings
tzdb_names_impl() {
  const date::tzdb& db = date::get_tzdb();

  const R_xlen_t n_current_zones = static_cast<R_xlen_t>(db.zones.size());
  const R_xlen_t n_historic_zones = static_cast<R_xlen_t>(db.links.size());
  const R_xlen_t n_zones = n_current_zones + n_historic_zones;

  R_xlen_t loc = 0;
  std::vector<std::string> zones(n_zones);

  for (R_xlen_t i = 0; i < n_current_zones; ++i, ++loc) {
    zones[loc] = db.zones[i].name();
  }
  for (R_xlen_t i = 0; i < n_historic_zones; ++i, ++loc) {
    zones[loc] = db.links[i].name();
  }

  // Should use C locale to sort with, giving same ordering as binary tzdb
  std::sort(zones.begin(), zones.end());

  cpp11::writable::strings out(n_zones);

  cpp11::unwind_protect([&] {
    for (R_xlen_t i = 0; i < n_zones; ++i) {
      const std::string& name = zones[i];
      SET_STRING_ELT(out, i, Rf_mkCharLenCE(name.c_str(), name.size(), CE_UTF8));
    }
  });

  return out;
}

#endif // USE_OS_TZDB

// -----------------------------------------------------------------------------

[[cpp11::register]]
cpp11::writable::strings
tzdb_names_cpp() {
  return tzdb_names_impl();
}
