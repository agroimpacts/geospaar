#' @import raster
#' @import sf
#' @import tidyverse

.onAttach <- function(libname, pkgname) {
  if (!interactive()) return()

  # Obtain the installed package information
  local_version <- utils::packageDescription("geospaar")

  m <- paste0("Welcome to the geospaar package, version ",
              local_version$Version)
  packageStartupMessage(m)
}
