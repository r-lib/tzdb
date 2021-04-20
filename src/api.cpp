#include <date/tz.h>
#include <cpp11/R.hpp>
#include <cpp11/protect.hpp>
#include <R_ext/Rdynload.h> // For DllInfo on R 3.3
#include <stdbool.h>

// -----------------------------------------------------------------------------

/*
 * To avoid throwing C++ exceptions across package boundaries, we catch
 * any exceptions and instead return a simple boolean indicating
 * success/failure. This loses date's specific error messages, but this
 * generally only matters for `locate_zone()`, for which the client can recreate
 * an equivalent error message as needed.
 */

bool
api_locate_zone(const std::string& name, const date::time_zone*& p_time_zone) {
  try {
    p_time_zone = date::locate_zone(name);
    return true;
  } catch (...) {
    return false;
  }
}

bool
api_get_local_info(const date::local_seconds& tp,
                   const date::time_zone* p_time_zone,
                   date::local_info& info) {
  try {
    info = p_time_zone->get_info(tp);
    return true;
  } catch (...) {
    return false;
  }
}

bool
api_get_sys_info(const date::sys_seconds& tp,
                 const date::time_zone* p_time_zone,
                 date::sys_info& info) {
  try {
    info = p_time_zone->get_info(tp);
    return true;
  } catch (...) {
    return false;
  }
}

// -----------------------------------------------------------------------------

[[cpp11::init]]
void api_init(DllInfo* dll){
  R_RegisterCCallable("tzdb", "api_locate_zone",    (DL_FUNC)api_locate_zone);
  R_RegisterCCallable("tzdb", "api_get_local_info", (DL_FUNC)api_get_local_info);
  R_RegisterCCallable("tzdb", "api_get_sys_info",   (DL_FUNC)api_get_sys_info);
}
